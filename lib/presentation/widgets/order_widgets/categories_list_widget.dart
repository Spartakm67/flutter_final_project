import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/categories_store/categories_store.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesListWidget extends StatelessWidget {
  final CategoriesStore categoriesStore;
  final ScrollController scrollController;
  final Function(String categoryId, String categoryName) onCategoryTap;

  const CategoriesListWidget({
    super.key,
    required this.categoriesStore,
    required this.scrollController,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (categoriesStore.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (categoriesStore.error != null) {
          return Center(
            child: Text(categoriesStore.error!),
          );
        }

        if (categoriesStore.categories.isEmpty) {
          return const Center(child: Text('Немає категорій'));
        }

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(8.0),
          itemCount: categoriesStore.categories.length,
          itemBuilder: (context, index) {
            final category = categoriesStore.categories[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () => onCategoryTap(
                  category.categoryId,
                  category.categoryName,
                ),
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
                        child: Text(
                          category.categoryName,
                          style: TextStyles.categoriesText,
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
    );
  }
}
