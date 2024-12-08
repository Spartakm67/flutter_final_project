import 'package:mobx/mobx.dart';
import 'package:firebase_core/firebase_core.dart';
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
      isInitialized = true;
    } catch (e) {
      errorMessage = 'Failed to initialize Firebase: $e';
    }
  }
}