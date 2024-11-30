import 'package:flutter/material.dart';
import 'package:flutter_final_project/data/models/poster/category_detail.dart';
import 'package:flutter_final_project/services/poster_api/category_detail_api_services.dart';

class CategoryDetailScreen extends StatefulWidget {
  final int categoryId;

  const CategoryDetailScreen({super.key, required this.categoryId});

  @override
  CategoryDetailScreenState createState() => CategoryDetailScreenState();
}

class CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late Future<CategoryDetail> _categoryDetail;

  @override
  void initState() {
    super.initState();
    _categoryDetail = ApiService.fetchCategoryDetail(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Details'),
      ),
      body: FutureBuilder<CategoryDetail>(
        future: _categoryDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final category = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${category.categoryId}',
                  // style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 8),
                Text(
                  'Name: ${category.categoryName}',
                  // style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 8),
                category.categoryPhoto != null
                    ? Image.network(
                  'https://joinposter.com${category.categoryPhoto!}',
                )
                    : const Text('No photo available'),
                const SizedBox(height: 16),
                Text(
                  'Color: ${category.categoryColor}',
                  // style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Visibility:',
                  // style: Theme.of(context).textTheme.subtitle1,
                ),
                ...category.visible.map((v) => Text(
                  'Spot ${v.spotId}: ${v.visible == 1 ? "Visible" : "Hidden"}',
                ),),
              ],
            ),
          );
        },
      ),
    );
  }
}
