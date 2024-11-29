import 'package:flutter/material.dart';
import 'package:flutter_final_project/data/models/poster/category.dart';
import 'package:flutter_final_project/services/poster_api/category_api_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CategoriesScreen(),
    );
  }
}

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  final CategoryApiServices _apiService = CategoryApiServices();
  late Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _apiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категорії товарів'),
      ),
      body: FutureBuilder<List<Category>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Помилка: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Немає категорій'));
          }

          final categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                leading: category.categoryPhoto != null
                    ? Image.network(
                        'https://joinposter.com${category.categoryPhoto}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      )
                    : Image.asset(
                        'assets/images/default_image.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                title: Text(category.categoryName),
                subtitle: Text('ID: ${category.categoryId}'),
              );
            },
          );
        },
      ),
    );
  }
}
