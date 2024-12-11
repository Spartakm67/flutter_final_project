import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_final_project/data/models/firebase/firebase_user_model.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @observable
  User? currentUser;

  @observable
  String? errorMessage;

  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;

  @action
  Future<void> signUpWithEmail(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = userCredential.user;
      final userModel = UserModel(
        email: email,
        createdAt: Timestamp.now(),
      );
      await saveInitialUserData(userModel);
    } catch (e) {
      errorMessage = 'Failed to register: ${e.toString()}';
      clearErrorMessageAfterDelay();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signInWithEmail(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = userCredential.user;
      isLoggedIn = true;
    } catch (e) {
      errorMessage = 'Failed to sign in: ${e.toString()}';
      clearErrorMessageAfterDelay();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signOut() async {
    isLoading = true;
    errorMessage = null;
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      currentUser = null;
      isLoggedIn = false;
    } catch (e) {
      errorMessage = 'Failed to sign out: ${e.toString()}';
      clearErrorMessageAfterDelay();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> signInWithGoogle() async {
    isLoading = true;
    errorMessage = null;

    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        errorMessage = 'Авторизацію скасовано.';
        return false;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      currentUser = userCredential.user;

      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser && currentUser != null) {
        final userModel = UserModel(
          email: currentUser!.email!,
          createdAt: Timestamp.now(),
          phoneNumber: currentUser!.phoneNumber,
          otherDetails: {
            'displayName': currentUser!.displayName,
            'photoURL': currentUser!.photoURL,
          },
        );

        await saveInitialUserData(userModel);
      }

      return true;
    } catch (e) {
      errorMessage = 'Помилка авторизації через Google: ${e.toString()}';
      return false;
    } finally {
      isLoading = false;
      clearErrorMessageAfterDelay();
    }
  }

  @action
  Future<void> saveInitialUserData(UserModel user) async {
    try {
      final usersCollection = _firestore.collection('users');
      await usersCollection.doc(user.email).set(user.toFirestore());
    } catch (e) {
      errorMessage = 'Failed to save user data: ${e.toString()}';
      clearErrorMessageAfterDelay();
    }
  }

  @action
  Future<void> updateUserData(
      String userId, Map<String, dynamic> updates,) async {
    try {
      final usersCollection = _firestore.collection('users');
      await usersCollection.doc(userId).update(updates);
    } catch (e) {
      errorMessage = 'Failed to update user data: ${e.toString()}';
      clearErrorMessageAfterDelay();
    }
  }

  @action
  Future<void> savePhoneNumber(String userId, String phoneNumber) async {
    try {
      await updateUserData(userId, {'phoneNumber': phoneNumber});
    } catch (e) {
      errorMessage = 'Failed to save phone number: ${e.toString()}';
      clearErrorMessageAfterDelay();
    }
  }

  @action
  Future<void> updateUserProfile(Map<String, dynamic> updates) async {
    if (currentUser == null) {
      errorMessage = 'No user is currently logged in.';
      return;
    }

    await updateUserData(currentUser!.email!, updates);
  }

  @action
  Future<void> saveUserPhoneNumber(String phoneNumber) async {
    if (currentUser == null) {
      errorMessage = 'No user is currently logged in.';
      return;
    }

    await savePhoneNumber(currentUser!.email!, phoneNumber);
  }

  @action
  void clearErrorMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      errorMessage = null;
    });
  }
}
