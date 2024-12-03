import 'package:flutter/material.dart';
import 'package:flutter_final_project/presentation/screens/product_detail_screen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/scroll_store/scroll_store.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/presentation/widgets/loading_image_indicator.dart';
import 'package:flutter_final_project/presentation/widgets/scroll_to_top_button.dart';
import 'package:flutter_final_project/presentation/widgets/custom_add_icon_button.dart';
import 'package:flutter_final_project/services/url_helper.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

class ProductListScreen extends StatefulWidget {
  final ProductStore productStore;
  final int categoryId;
  final String categoryName;

  ProductListScreen({
    super.key,
    required this.productStore,
    required this.categoryId,
    required this.categoryName,
  }) {
    productStore.fetchProducts(categoryId.toString());
  }

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollStore _scrollStore = ScrollStore();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
        title: Text(
          widget.categoryName,
          style: TextStyles.greetingsText,
        ),
      ),
      body: Observer(
        builder: (_) {
          if (widget.productStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.productStore.error != null) {
            return Center(
              child: Text(widget.productStore.error!),
            );
          }
          final filteredProducts = widget.productStore.products
              .where(
                (product) =>
                    int.tryParse(product.categoryProductId) ==
                    widget.categoryId,
              )
              .toList();
          if (filteredProducts.isEmpty) {
            return const Center(child: Text('No products found'));
          }
          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
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
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2.0,
                    horizontal: 12.0,
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productName,
                              style: TextStyles.categoriesText,
                              // style: Theme.of(context).textTheme.headline2,
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Інгредієнти: ',
                                    style: TextStyles.habitKeyText,
                                  ),
                                  TextSpan(
                                    text: product.ingredients
                                        .map((i) => i.name)
                                        .join(", "),
                                    style: TextStyles.spanKeyText,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Ціна: ',
                                    style: TextStyles.habitKeyText,
                                  ),
                                  TextSpan(
                                    text:
                                        '${(product.price / 100).toStringAsFixed(2)} грн',
                                    style: TextStyles.authText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Hero(
                              tag: 'product-${product.productId}',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  UrlHelper.getFullImageUrl(product.photo),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return LoadingImageIndicator(
                                      loadingProgress: loadingProgress,
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/default_image.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 50,
                              child: Observer(
                                builder: (_) {
                                  final counter = widget.productStore
                                          .counters[product.productId] ??
                                      0;
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Opacity(
                                        opacity: counter > 0 ? 1.0 : 0.0,
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: counter > 0
                                                  ? () {
                                                      widget.productStore
                                                          .decrementCounter(
                                                        product.productId,
                                                      );
                                                    }
                                                  : null,
                                            ),
                                            SizedBox(
                                              width: 20,
                                              child: Text(
                                                '$counter',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      CustomIconButton(
                                        icon: Icons.add,
                                        onPressed: () {
                                          widget.productStore.incrementCounter(
                                            product.productId,
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
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
      floatingActionButton: Observer(
        builder: (_) {
          return ScrollToTopButton(
            scrollStore: _scrollStore,
            scrollController: _scrollController,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
