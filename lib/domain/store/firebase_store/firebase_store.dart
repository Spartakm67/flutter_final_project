import 'package:mobx/mobx.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_final_project/firebase_options.dart';

part 'firebase_store.g.dart';

class FirebaseStore = FirebaseStoreBase with _$FirebaseStore;

abstract class FirebaseStoreBase with Store {
  @observable
  bool isInitialized = false;

  @observable
  String? errorMessage;

  @action
  Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await FirebaseAppCheck.instance.activate(
        // webRecaptchaSiteKey: 'your-web-recaptcha-site-key', // Для вебу (якщо необхідно)
        androidProvider: AndroidProvider.playIntegrity,
        );

      isInitialized = true;
    } catch (e) {
      errorMessage = 'Failed to initialize Firebase: $e';
    }
  }
}