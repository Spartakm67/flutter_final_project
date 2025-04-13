import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/data/models/poster/category.dart';
import 'package:flutter_final_project/services/firebase_functions/firebase_config_service.dart';

// class CategoryApiServices {
//   static Future<List<Category>> fetchCategories() async {
//     try {
//       final firebaseConfig = await FirebaseConfigService.fetchFirebaseConfig();
//       final String baseUrl = firebaseConfig['poster']['apiGetCategories'];
//       final String token = firebaseConfig['poster']['token'];
//
//       final url = Uri.parse('$baseUrl?token=$token&fiscal=1');
//
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body)['response'];
//
//         final additionsCategory = data
//             .map((json) => Category.fromJson(json as Map<String, dynamic>))
//             .where((category) =>
//         category.categoryName.toLowerCase() == 'добавки',)
//             .toList();
//
//         if (additionsCategory.isEmpty) {
//           throw Exception('Категорія "Добавки" не знайдена');
//         }
//
//         return additionsCategory; // Повертаємо список з 1 елементом
//       } else {
//         throw Exception('Не вдалося отримати категорії: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Помилка при отриманні категорії "Добавки": $e');
//       rethrow;
//     }
//   }
// }

// class AdditionsApiService {
//   // ⬇️ Новий метод: отримає першу категорію з назвою "Добавки"
//   static Future<Category> fetchAdditionsCategory() async {
//     final categories = await fetchCategories();
//     return categories.first;
//   }
//
//   // ⬇️ Твій існуючий метод, який шукає "Добавки" серед усіх категорій
//   static Future<List<Category>> fetchCategories() async {
//     try {
//       final firebaseConfig = await FirebaseConfigService.fetchFirebaseConfig();
//       final String baseUrl = firebaseConfig['poster']['apiGetCategories'];
//       final String token = firebaseConfig['poster']['token'];
//
//       final url = Uri.parse('$baseUrl?token=$token&fiscal=1');
//
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body)['response'];
//
//         final additionsCategory = data
//             .map((json) => Category.fromJson(json as Map<String, dynamic>))
//             .where((category) =>
//         category.categoryName.toLowerCase() == 'добавки')
//             .toList();
//
//         if (additionsCategory.isEmpty) {
//           throw Exception('Категорія "Добавки" не знайдена');
//         }
//
//         return additionsCategory; // Повертаємо список з 1 елементом
//       } else {
//         throw Exception('Не вдалося отримати категорії: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Помилка при отриманні категорії "Добавки": $e');
//       rethrow;
//     }
//   }
// }
