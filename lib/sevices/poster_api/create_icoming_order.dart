import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://joinposter.com/api/incomingOrders.createIncomingOrder';
  static const String token = '687409:4164553abf6a031302898da7800b59fb';

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