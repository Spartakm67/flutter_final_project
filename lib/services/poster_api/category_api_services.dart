import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/data/models/poster/category.dart';
import 'package:flutter_final_project/services/firebase_functions/firebase_config_service.dart';

class CategoryApiServices {
  static Future<List<Category>> fetchCategories() async {
    try {
      final firebaseConfig = await FirebaseConfigService.fetchFirebaseConfig();
      final String baseUrl = firebaseConfig['poster']['apiGetCategories'];
      final String token = firebaseConfig['poster']['token'];

      final url = Uri.parse('$baseUrl?token=$token&fiscal=1');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['response'];

        const excludedWords = [
          'Glovo',
          'Сборки',
          'Морозиво',
          'Горячи напої',
        ];

        final filteredCategories = data
            .map((json) => Category.fromJson(json as Map<String, dynamic>))
            .where(
              (category) => !excludedWords.any(
                (word) => category.categoryName
                    .toLowerCase()
                    .contains(word.toLowerCase()),
              ),
            )
            .toList();

        return filteredCategories;
      } else {
        throw Exception('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
