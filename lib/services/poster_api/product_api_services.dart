import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';

class ProductApiServices {
  static const String baseUrl = 'https://joinposter.com/api';
  static final String token = dotenv.env['TOKEN'] ?? '';

  Future<List<Product>> getProductsByCategory(String categoryProductId) async {
    final url = Uri.parse('$baseUrl/menu.getProducts?'
        'token=$token&category_id=$categoryProductId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List productsJson = data['response'] ?? [];

      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
