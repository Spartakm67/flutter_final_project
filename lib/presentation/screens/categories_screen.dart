import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/categories_store/categories_store.dart';
import 'package:flutter_final_project/domain/store/scroll_store/scroll_store.dart';
import 'package:flutter_final_project/presentation/screens/category_detail_screen.dart';
import 'package:flutter_final_project/presentation/widgets/scroll_to_top_button.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
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
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryDetailScreen(
                          categoryId: int.parse(category.categoryId),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: category.categoryPhoto != null
                              ? Image.network(
                                  'https://joinposter.com${category.categoryPhoto}',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image, size: 70),
                                )
                              : Image.asset(
                                  'assets/images/default_image.png',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.categoryName,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
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
