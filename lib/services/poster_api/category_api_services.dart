import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/data/models/poster/category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryApiServices {
  static const String baseUrl = 'https://joinposter.com/api/menu.getCategories';
  static final String token = dotenv.env['TOKEN'] ?? '';

  static Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('$baseUrl?token=$token&fiscal=1');
    final response = await http.get(url);

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['response'];
      final filteredCategories = data
          .map((json) => Category.fromJson(json as Map<String, dynamic>))
          .where((category) {
        const excludedWords = ['Glovo', 'Сборки', 'Морозиво', 'Горячи напої',];
        return !excludedWords.any((word) => category.categoryName.contains(word));
      })
          .toList();
      return filteredCategories;
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}
