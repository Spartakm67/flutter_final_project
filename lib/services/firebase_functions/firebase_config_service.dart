import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConfigService {
  static String endpoint =
  dotenv.env['ENDPOINT']!;

  static Future<Map<String, dynamic>> fetchFirebaseConfig() async {
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final config = jsonDecode(response.body) as Map<String, dynamic>;
      return config;
    } else {
      throw Exception('Failed to load Firebase config');
    }
  }
}

