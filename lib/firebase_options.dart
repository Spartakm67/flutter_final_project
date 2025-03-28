// File generated by FlutterFire CLI.
// ignore_for_file: type=lint

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```

class DefaultFirebaseOptions {
  static FirebaseOptions? _firebaseOptions;

  static Future<void> loadFirebaseConfig() async {
    final String endpoint =
    dotenv.env['ENDPOINT']!;

    try {
      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        print("Firebase step 1 config loaded successfully");
        final firebaseConfig = jsonDecode(response.body);
        _firebaseOptions = _getPlatformSpecificOptions(firebaseConfig);
        print('Firebase step 2 config loaded successfully');
      } else {
        print("Error: ${response.statusCode}");
        throw Exception('Failed to load Firebase config, status: ${response.statusCode}');
      }
    } catch (e) {
      print("Error step 1 loading Firebase config: $e");
      throw Exception('Error step 2 loading Firebase config: $e');
    }
  }

  static FirebaseOptions get currentPlatform {
    if (_firebaseOptions == null) {
      throw Exception('Firebase configuration not loaded');
    }
    return _firebaseOptions!;
  }

  static FirebaseOptions _getPlatformSpecificOptions(Map<String, dynamic> firebaseConfig) {
    if (kIsWeb) {
      return _getWebOptions(firebaseConfig);
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _getAndroidOptions(firebaseConfig);
      case TargetPlatform.iOS:
        return _getIosOptions(firebaseConfig);
      case TargetPlatform.macOS:
        return _getIosOptions(firebaseConfig);
      case TargetPlatform.windows:
        return _getWebOptions(firebaseConfig);
      case TargetPlatform.linux:
        throw UnsupportedError('Linux is not supported.');
      default:
        throw UnsupportedError('Platform not supported.');
    }
  }

  static FirebaseOptions _getWebOptions(Map<String, dynamic> firebaseConfig) {
    return FirebaseOptions(
      apiKey: firebaseConfig['webApiKey'],
      appId: firebaseConfig['appId']['web'],
      messagingSenderId: firebaseConfig['messagingSenderId'],
      projectId: firebaseConfig['projectId'],
      authDomain: firebaseConfig['authDomain'],
      storageBucket: firebaseConfig['storageBucket'],
      measurementId: firebaseConfig['measurementId'],
    );
  }

  static FirebaseOptions _getAndroidOptions(Map<String, dynamic> firebaseConfig) {
    return FirebaseOptions(
      apiKey: firebaseConfig['androidApiKey'],
      appId: firebaseConfig['appId']['android'],
      messagingSenderId: firebaseConfig['messagingSenderId'],
      projectId: firebaseConfig['projectId'],
      storageBucket: firebaseConfig['storageBucket'],
    );
  }

  static FirebaseOptions _getIosOptions(Map<String, dynamic> firebaseConfig) {
    return FirebaseOptions(
      apiKey: firebaseConfig['iosApiKey'],
      appId: firebaseConfig['appId']['ios'],
      messagingSenderId: firebaseConfig['messagingSenderId'],
      projectId: firebaseConfig['projectId'],
      storageBucket: firebaseConfig['storageBucket'],
      iosBundleId: firebaseConfig['iosBundleId'],
    );
  }
}


