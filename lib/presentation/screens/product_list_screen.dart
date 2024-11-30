import 'package:flutter/material.dart';
import 'package:flutter_final_project/presentation/screens/product_detail_screen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/domain/store/scroll_store/scroll_store.dart';

import 'package:flutter_final_project/presentation/widgets/scroll_to_top_button.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:shimmer/shimmer.dart';

class ProductListScreen extends StatelessWidget {
  final ProductStore productStore;
  final int categoryId;

  ProductListScreen({
    super.key,
    required this.productStore,
    required this.categoryId,
  }) {
    productStore.fetchProducts(categoryId.toString());
  }

  String getFullImageUrl(String path) {
    const String baseUrl = 'https://joinposter.com';
    return Uri.parse(baseUrl).resolve(path.replaceAll('\\', '')).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Observer(
        builder: (_) {
          final filteredProducts = productStore.products
              .where(
                (product) =>
                    int.tryParse(product.categoryProductId) == categoryId,
              )
              .toList();
          if (filteredProducts.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              final product = filteredProducts[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 2.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productName,
                              // style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Ціна: ${(product.price / 100).toStringAsFixed(2)}\n'
                              'Cooking Time: ${product.cookingTime}s\n'
                              'Ingredients: ${product.ingredients.map((i) => i.name).join(", ")}',
                              // style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Hero(
                            tag: product.productId,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                getFullImageUrl(product.photo),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 75,
                                  );
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              // TODO: Implement adding product logic
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
