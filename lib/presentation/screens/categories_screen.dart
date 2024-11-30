import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/categories_store/categories_store.dart';
import 'package:flutter_final_project/domain/store/scroll_store/scroll_store.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/presentation/screens/category_detail_screen.dart';
import 'package:flutter_final_project/presentation/screens/product_list_screen.dart';
import 'package:flutter_final_project/presentation/widgets/scroll_to_top_button.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  final ProductStore productStore = ProductStore();
  final CategoriesStore _categoriesStore = CategoriesStore();
  final ScrollStore _scrollStore = ScrollStore();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _categoriesStore.fetchCategories();

    _scrollController.addListener(() {
      _scrollStore.updateScrollPosition(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категорії товарів'),
      ),
      body: Observer(
        builder: (context) {
          if (_categoriesStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_categoriesStore.error != null) {
            return Center(
              child: Text(_categoriesStore.error!),
            );
          }

          if (_categoriesStore.categories.isEmpty) {
            return const Center(child: Text('Немає категорій'));
          }

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            itemCount: _categoriesStore.categories.length,
            itemBuilder: (context, index) {
              final category = _categoriesStore.categories[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductListScreen(
                          productStore: productStore,
                          categoryId: int.parse(category.categoryId),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: category.categoryPhoto != null
                              ? Image.network(
                                  'https://joinposter.com${category.categoryPhoto}',
                                  width: 75,
                                  height: 75,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 75,
                                        height: 75,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image, size: 75),
                                )
                              : Image.asset(
                                  'assets/images/default_image.png',
                                  width: 75,
                                  height: 75,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 30.0),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                category.categoryName,
                                style: TextStyles.categoriesText,
                                // textAlign: TextAlign.center,
                              ),
                              Text(
                                category.categoryId,
                                style: TextStyles.categoriesText,
                                // textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: ScrollToTopButton(
        scrollStore: _scrollStore,
        scrollController: _scrollController,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
