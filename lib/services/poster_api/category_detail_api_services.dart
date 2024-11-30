import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/data/models/poster/category_detail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static const String _baseUrl = 'https://joinposter.com/api/';
  static final String _token = dotenv.env['TOKEN'] ?? '';

  static Future<CategoryDetail> fetchCategoryDetail(int categoryId) async {
    final Uri url = Uri.parse(
      '${_baseUrl}menu.getCategory?token=$_token&category_id=$categoryId&1c=true',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['response'];

      return CategoryDetail.fromJson(data);
    } else {
      throw Exception('Failed to fetch category details');
    }
  }
}
