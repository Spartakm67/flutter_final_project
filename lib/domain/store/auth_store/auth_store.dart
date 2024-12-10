import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
  void clearErrorMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      errorMessage = null;
    });
  }
}
