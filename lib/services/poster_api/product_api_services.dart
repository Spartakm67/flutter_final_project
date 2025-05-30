import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/data/models/poster/product.dart';
import 'package:flutter_final_project/services/firebase_functions/firebase_config_service.dart';

String formatIngredients(Ingredient ingredient) {
  String subIng = ingredient.subIngredients.isNotEmpty
      ? " (${ingredient.subIngredients.map(formatIngredients).join(', ')})"
      : "";

  return ingredient.name + subIng;
}

class ProductApiServices {
  Future<List<Product>> getProductsByCategory(String categoryProductId) async {
    try {
      final firebaseConfig = await FirebaseConfigService.fetchFirebaseConfig();
      final String baseUrl = firebaseConfig['poster']['baseUrl'];
      final String token = firebaseConfig['poster']['token'];

      final url = Uri.parse('$baseUrl/api/menu.getProducts?'
          'token=$token&category_id=$categoryProductId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> productsJson = data['response'] ?? [];

        const excludedWords = [
          'Архів',
          'Старий рецепт',
          'Непридатний',
        ];

        final filteredProducts = productsJson
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .where(
              (product) =>
                  product.visible == 1 &&
                  !excludedWords.any(
                    (word) => product.productName
                        .toLowerCase()
                        .contains(word.toLowerCase()),
                  ),
            )
            .toList();

        return filteredProducts;
      } else {
        throw Exception(
          'Failed to load products: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
