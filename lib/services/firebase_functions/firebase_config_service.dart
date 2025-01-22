import 'dart:convert';
import 'package:http/http.dart' as http;

class FirebaseConfigService {
  static const String endpoint =
      'https://us-central1-pancake-workshop-app.cloudfunctions.net/getFirebaseConfig';

  static Future<Map<String, dynamic>> fetchFirebaseConfig() async {
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final config = jsonDecode(response.body) as Map<String, dynamic>;
      print(config);
      return config;
    } else {
      throw Exception('Failed to load Firebase config');
    }
  }
}

// class FirebaseConfigService {
//   static const String endpoint =
//       'https://us-central1-pancake-workshop-app.cloudfunctions.net/getFirebaseConfig';
//
//   static Future<Map<String, dynamic>> fetchFirebaseConfig() async {
//     final response = await http.get(Uri.parse(endpoint));
//     if (response.statusCode == 200) {
//       final config = jsonDecode(response.body);
//       print(config);
//       return config;
//     } else {
//       throw Exception('Failed to load Firebase config');
//     }
//   }
// }
