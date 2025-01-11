import 'package:mobx/mobx.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_final_project/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

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
      final locale = Platform.localeName;
      FirebaseAuth.instance.setLanguageCode(locale.isNotEmpty ? locale : 'en');

      await FirebaseAppCheck.instance.activate(
        // webProvider: ReCaptchaV3Provider(dotenv.env['RECAPTCHA_KEY'] ?? ''),
        // androidProvider: AndroidProvider.playIntegrity,
        androidProvider: AndroidProvider.debug,
        // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
        // your preferred provider. Choose from:
        // 1. Debug provider
        // 2. Device Check provider
        // 3. App Attest provider
        // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
        // appleProvider: AppleProvider.appAttest, // Or use Device Check provider
        );

      isInitialized = true;
    } catch (e) {
      errorMessage = 'Failed to initialize Firebase: $e';
    }
  }
}