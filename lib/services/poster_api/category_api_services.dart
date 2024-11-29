import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/data/models/poster/category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryApiServices {
  static const String baseUrl = 'https://joinposter.com/api/menu.getCategories';
  static final String token = dotenv.env['TOKEN'] ?? '';

  Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('$baseUrl?token=$token&fiscal=1');
    final response = await http.get(url);

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print('Parsed data: $data');

      final List<dynamic> categoriesJson = data['response'];
      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
