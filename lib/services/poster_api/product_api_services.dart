import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';
import 'package:flutter_final_project/services/firebase_functions/firebase_config_service.dart';

class ProductApiServices {
  Future<List<Product>> getProductsByCategory(String categoryProductId) async {
    try {
      final firebaseConfig = await FirebaseConfigService.fetchFirebaseConfig();
      final String baseUrl = firebaseConfig['poster']['baseUrl'];
      final String token = firebaseConfig['poster']['token'];

      final url = Uri.parse('$baseUrl/api/menu.getProducts?'
          'token=$token&category_id=$categoryProductId');
      print('URL: $url');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        final data = jsonDecode(response.body);
        final List<dynamic> productsJson = data['response'] ?? [];

        const excludedWords = [
          'Архів',
          'Старий рецепт',
          'Непридатний',
        ];

        final filteredProducts = productsJson
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .where((product) =>
        !excludedWords.any((word) =>
            product.productName.toLowerCase().contains(word.toLowerCase()),),)
            .toList();

        print('Filtered products: $filteredProducts');
        return filteredProducts;
      } else {
        throw Exception(
            'Failed to load products: ${response.statusCode} - ${response.reasonPhrase}',);
      }
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }
}

// class ProductApiServices {
//   static const String baseUrl = 'https://joinposter.com/api';
//   static final String token = dotenv.env['TOKEN'] ?? '';
//
//   Future<List<Product>> getProductsByCategory(String categoryProductId) async {
//     final url = Uri.parse('$baseUrl/menu.getProducts?'
//         'token=$token&category_id=$categoryProductId');
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final List productsJson = data['response'] ?? [];
//
//       return productsJson.map((json) => Product.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
// }

