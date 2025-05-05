import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_final_project/data/models/firebase/firebase_user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @observable
  User? currentUser;

  @observable
  String? errorMessage;

  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;

  @observable
  String? verificationId;

  @observable
  String? phoneNumber;

  @observable
  bool isCodeSent = false;

  @observable
  bool isWaitingForSms = false;

  int? _resendToken;

  void Function(String message)? showErrorMessage;

  @action
  void setPhoneNumber(String value) {
    phoneNumber = value.trim();
  }

  @action
  bool isPhoneNumberValid(String number) {
    final regex = RegExp(r'^\d{9}$');
    return regex.hasMatch(number);
  }

  @action
  Future<void> sendOTP() async {
    if (!isPhoneNumberValid(phoneNumber!)) {
      errorMessage = 'Номер телефону має містити 9 цифр!';
      clearErrorMessageAfterDelay();
      return;
    }
    isLoading = true;
    errorMessage = null;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: '+380$phoneNumber',
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          currentUser = auth.currentUser;
          if (currentUser != null) {
            await saveUserPhoneNumber(phoneNumber!);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          errorMessage = 'Verification failed: ${e.message}';
          clearErrorMessageAfterDelay();
          isWaitingForSms = false;
        },
        codeSent: (String verId, int? resendToken) {
          verificationId = verId;
          _resendToken = resendToken;
          isCodeSent = true;
          isWaitingForSms = true;
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
      );
    } catch (e) {
      errorMessage = 'Failed to send OTP: ${e.toString()}';
      clearErrorMessageAfterDelay();
      isWaitingForSms = false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> verifyOTP(String smsCode) async {
    isLoading = true;
    errorMessage = null;
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: smsCode,
      );
      final userCredential = await auth.signInWithCredential(credential);
      currentUser = userCredential.user;
      isLoggedIn = true;
      if (currentUser != null) {
        final userModel = UserModel(
          userId: currentUser!.uid,
          phoneNumber: phoneNumber!,
          createdAt: Timestamp.now(),
        );
        await saveInitialUserData(userModel);

        // 🔺Збереження UID у вже відкритий Hive box
        final authBox = Hive.box('authBox');
        await authBox.put('uid', currentUser!.uid);

      }
      isWaitingForSms = false;
    } catch (e) {
      errorMessage = 'Failed to verify OTP: ${e.toString()}';
      clearErrorMessageAfterDelay();
      isWaitingForSms = false;
      throw Exception('OTP verification failed');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signUpWithEmail(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = userCredential.user;
      final userModel = UserModel(
        userId: currentUser!.uid,
        email: email,
        createdAt: Timestamp.now(),
      );
      await saveInitialUserData(userModel);
    } catch (e) {
      if (e is FirebaseAuthException) {
        errorMessage = getCustomErrorMessage(e.code);
        showErrorMessage?.call(errorMessage!);
      } else {
        errorMessage = 'Невідома помилка: ${e.toString()}';
        showErrorMessage?.call(errorMessage!);
      }
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
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = userCredential.user;
      isLoggedIn = true;
    } catch (e) {
      if (e is FirebaseAuthException) {
        errorMessage = getCustomErrorMessage(e.code);
        showErrorMessage?.call(errorMessage!);
      } else {
        errorMessage = 'Невідома помилка: ${e.toString()}';
        showErrorMessage?.call(errorMessage!);
      }
      clearErrorMessageAfterDelay();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> resetPassword(String email) async {
    isLoading = true;
    errorMessage = null;

    try {
      await auth.sendPasswordResetEmail(email: email);
      errorMessage = 'Password reset email sent. Check your inbox.';
    } catch (e) {
      errorMessage = 'Failed to send reset email: ${e.toString()}';
      showErrorMessage?.call(errorMessage!);
      clearErrorMessageAfterDelay();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> resetReCapPassword(String email) async {
    isLoading = true;
    errorMessage = null;

    try {
      await auth.sendPasswordResetEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://flutterfinalproject.page.link/reset-password',
          handleCodeInApp: true,
          androidPackageName: 'com.example.flutter_final_project',
          androidMinimumVersion: '21',
        ),
      );
      errorMessage = 'Password reset email sent. Check your inbox.';
    } catch (e) {
      errorMessage = 'Failed to send reset email: ${e.toString()}';
      showErrorMessage?.call(errorMessage!);
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
      await auth.signOut();
      // await _googleSignIn.signOut();
      currentUser = null;
      isLoggedIn = false;

      // ✅ ДОДАНО: Видалення UID з Hive (authBox вже відкритий у main)
      await Hive.box('authBox').delete('uid');

    } catch (e) {
      errorMessage = 'Failed to sign out: ${e.toString()}';
      showErrorMessage?.call(errorMessage!);
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

      final userCredential = await auth.signInWithCredential(credential);
      currentUser = userCredential.user;

      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser && currentUser != null) {
        final userModel = UserModel(
          userId: currentUser!.uid,
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

      isLoggedIn = true;
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
      await usersCollection.doc(user.userId).set(user.toFirestore());
    } catch (e) {
      errorMessage = 'Failed to save user data: ${e.toString()}';
      clearErrorMessageAfterDelay();
    }
  }

  @action
  Future<void> updateUserData(
    String userId,
    Map<String, dynamic> updates,
  ) async {
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

    await updateUserData(currentUser!.uid, updates);
  }

  @action
  Future<void> saveUserPhoneNumber(String phoneNumber) async {
    if (currentUser == null) {
      errorMessage = 'No user is currently logged in.';
      return;
    }

    await savePhoneNumber(currentUser!.uid, phoneNumber);
  }

  @action
  void clearErrorMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      errorMessage = null;
    });
  }

  @action
  Future<void> restoreSessionFromHive() async {
    final savedUid = Hive.box('authBox').get('uid');
    final user = auth.currentUser;

    print('🔥 UID in Hive: $savedUid');
    print('🔥 Firebase currentUser: ${user?.uid}');

    if (savedUid != null && user != null && user.uid == savedUid) {
      currentUser = user;
      isLoggedIn = true;
      print('✅ Сесія відновлена автоматично');
    } else {
      currentUser = null;
      isLoggedIn = false;
      print('❌ Сесію не вдалося відновити');
    }
  }

  String getCustomErrorMessage(String firebaseErrorCode) {
    switch (firebaseErrorCode) {
      case 'invalid-credential':
        return 'Поля email та/або password мають не коректні значення. Будь ласка, перевірте введені дані.';
      case 'invalid-email':
        return 'Невірний формат email. Будь ласка, перевірте введені дані.';
      case 'user-not-found':
        return 'Користувача з таким email не знайдено.';
      case 'wrong-password':
        return 'Невірний пароль. Спробуйте ще раз.';
      case 'email-already-in-use':
        return 'Ця email-адреса вже використовується іншим обліковим записом.';
      case 'weak-password':
        return 'Пароль занадто слабкий. Використовуйте більше 6 символів.';
      case 'too-many-requests':
        return 'Забагато невдалих спроб. Будь ласка, спробуйте пізніше.';
      case 'network-request-failed':
        return 'Помилка мережі. Перевірте своє інтернет-з’єднання.';
      default:
        return 'Сталася помилка. Спробуйте ще раз.';
    }
  }
}
