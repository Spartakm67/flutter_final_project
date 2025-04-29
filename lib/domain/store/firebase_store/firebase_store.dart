import 'package:mobx/mobx.dart';
import 'package:firebase_core/firebase_core.dart';
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
      await DefaultFirebaseOptions.loadFirebaseConfig();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final locale = Platform.localeName;
      FirebaseAuth.instance.setLanguageCode(locale.isNotEmpty ? locale : 'en');

      isInitialized = true;
    } catch (e) {
      errorMessage = 'Failed to initialize Firebase: $e';
      isInitialized = false;
    }
  }
}

