import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/data/models/poster/category.dart';
import 'package:flutter_final_project/services/firebase_functions/firebase_config_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryApiServices {
  static Future<List<Category>> fetchCategories() async {
    try {
      final firebaseConfig = await FirebaseConfigService.fetchFirebaseConfig();
      final String baseUrl = firebaseConfig['poster']['apiGetCategories'];
      final String token = firebaseConfig['poster']['token'];

      final url = Uri.parse('$baseUrl?token=$token&fiscal=1');
      print('URL: $url');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        final List<dynamic> data = json.decode(response.body)['response'];

        const excludedWords = [
          'Glovo',
          'Сборки',
          'Морозиво',
          'Горячи напої',
        ];

        final filteredCategories = data
            .map((json) => Category.fromJson(json as Map<String, dynamic>))
            .where((category) =>
        !excludedWords.any((word) =>
            category.categoryName.toLowerCase().contains(word.toLowerCase())))
            .toList();

        print('Filtered categories: $filteredCategories');
        return filteredCategories;
      } else {
        throw Exception('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      rethrow;
    }
  }
}

// class CategoryApiServices {
//   static const String baseUrl = 'https://joinposter.com/api/menu.getCategories';
//   static final String token = dotenv.env['TOKEN'] ?? '';
//
//   static Future<List<Category>> fetchCategories() async {
//     final url = Uri.parse('$baseUrl?token=$token&fiscal=1');
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body)['response'];
//       final filteredCategories = data
//           .map((json) => Category.fromJson(json as Map<String, dynamic>))
//           .where((category) {
//         const excludedWords = [
//           'Glovo',
//           'Сборки',
//           'Морозиво',
//           'Горячи напої',
//         ];
//         return !excludedWords
//             .any((word) => category.categoryName.contains(word));
//       }).toList();
//       return filteredCategories;
//     } else {
//       throw Exception('Failed to fetch categories');
//     }
//   }
// }
