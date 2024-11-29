import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static const String baseUrl = 'https://joinposter.com/api/incomingOrders.createIncomingOrder';
  static final String token = dotenv.env['TOKEN'] ?? '';

  static Future<Map<String, dynamic>> createIncomingOrder(Map<String, dynamic> orderData) async {
    final url = Uri.parse('$baseUrl?token=$token');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create incoming order: ${response.body}');
    }
  }
}

