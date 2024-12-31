import 'package:flutter/material.dart';
import 'package:flutter_final_project/presentation/screens/product_detail_screen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/scroll_store/scroll_store.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/domain/store/categories_store/categories_store.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/presentation/widgets/loading_image_indicator.dart';
import 'package:flutter_final_project/presentation/widgets/scroll_to_top_button.dart';
import 'package:flutter_final_project/presentation/widgets/custom_add_icon_button.dart';
import 'package:flutter_final_project/presentation/widgets/custom_dialog.dart';
import 'package:flutter_final_project/presentation/widgets/custom_burger_button.dart';
import 'package:flutter_final_project/presentation/widgets/contacts/contacts_widget.dart';
import 'package:flutter_final_project/presentation/widgets/contacts/burger_widget.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/bottom_cart_bar.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/categories_list_widget.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/cart_preview_container.dart';
import 'package:flutter_final_project/services/url_helper.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  final CategoriesStore categoriesStore;
  final ProductStore productStore;
  final int categoryId;
  final String categoryName;

  ProductListScreen({
    super.key,
    required this.productStore,
    required this.categoryId,
    required this.categoryName,
    required this.categoriesStore,
  }) {
    productStore.fetchProducts(categoryId.toString());
  }

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ScrollController _scrollController;
  late ScrollStore _scrollStore;

  @override
  void initState() {
    super.initState();
    _scrollStore = ScrollStore();
    _scrollController = ScrollController();
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
    final cartStore = Provider.of<CartStore>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.categoryName,
              style: TextStyles.greetingsText,
            ),
            const SizedBox(width: 1),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: CategoriesListWidget(
                        categoriesStore: widget.categoriesStore,
                        scrollController: ScrollController(),
                        onCategoryTap: (categoryId, categoryName) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductListScreen(
                                categoriesStore: widget.categoriesStore,
                                productStore: widget.productStore,
                                categoryId: int.parse(categoryId),
                                categoryName: categoryName,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.deepOrange,
              ),
            ),
            const Spacer(),
            CustomBurgerButton(
              backgroundColor: Colors.white,
              lineColor: Colors.black,
              borderColor: Colors.black,
              borderRadius: 12.0,
              onTap: () => showDialog(
                context: context,
                builder: (context) => const BurgerWidget(),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
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
          return Stack(
            children: [
              ListView.builder(
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
                                            '${(product.price / 100).toStringAsFixed(0)} грн',
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
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return LoadingImageIndicator(
                                          loadingProgress: loadingProgress,
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
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
                                      final counter = cartStore
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
                                                  icon:
                                                      const Icon(Icons.remove),
                                                  onPressed: counter > 0
                                                      ? () {
                                                          cartStore
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
                                              cartStore.incrementCounter(
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
                            builder: (_) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Observer(
                  builder: (_) {
                    final totalItems = cartStore.totalItems;
                    final totalPrice = cartStore.totalCombinedOrderPrice;
                    return BottomCartBar(
                      totalItems: totalItems,
                      totalPrice: totalPrice,
                      onOrder: () {
                        CustomDialog.show(
                          context: context,
                          builder: (_) => const CartPreviewContainer(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: ScrollToTopButton(
        scrollStore: _scrollStore,
        scrollController: _scrollController,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
