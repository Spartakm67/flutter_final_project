import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/data/models/poster/incoming_order.dart';
import 'package:flutter_final_project/services/firebase_functions/firebase_config_service.dart';

class OrderApiService {
  static Future<Map<String, dynamic>> sendOrder(IncomingOrder order) async {
    try {
      final firebaseConfig = await FirebaseConfigService.fetchFirebaseConfig();
      final String baseUrl = firebaseConfig['poster']['baseUrl'];
      final String token = firebaseConfig['poster']['token'];

      final url = Uri.parse(
          '$baseUrl/api/incomingOrders.createIncomingOrder?token=$token',);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(order.toJson()),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw Exception(
          'Failed to create incoming order: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
