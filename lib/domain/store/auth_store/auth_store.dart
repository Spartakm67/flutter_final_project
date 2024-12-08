import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @observable
  User? currentUser;

  @observable
  String? errorMessage;

  @observable
  bool isLoading = false;

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
      currentUser = null;
    } catch (e) {
      errorMessage = 'Failed to sign out: ${e.toString()}';
      clearErrorMessageAfterDelay();
    } finally {
      isLoading = false;
    }
  }

  @action
  void clearErrorMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      errorMessage = null;
    });
  }
}
