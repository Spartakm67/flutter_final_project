import 'package:flutter/material.dart';
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
import 'package:flutter_final_project/presentation/widgets/contacts/burger_widget.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/bottom_cart_bar.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/cart_preview_container.dart';
import 'package:flutter_final_project/services/url_helper.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:provider/provider.dart';
import '../../data/models/poster/product.dart';

class AdditionsScreen extends StatefulWidget {
  final CategoriesStore categoriesStore;
  final ProductStore productStore;
  final String categoryId;
  final String categoryName;

  const AdditionsScreen({
    super.key,
    required this.productStore,
    required this.categoriesStore,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<AdditionsScreen> createState() => _AdditionsScreenState();
}

class _AdditionsScreenState extends State<AdditionsScreen> {
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

    widget.productStore.fetchProducts(
      widget.categoriesStore.additionsCategory.categoryId,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context, listen: true);
    final category = widget.categoriesStore.additionsCategory;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category.categoryName,
              style: TextStyles.greetingsText,
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
            return Center(child: Text(widget.productStore.error!));
          }

          final filteredProducts = widget.productStore.products
              .where(
                (product) =>
                    product.categoryProductId ==
                    widget.categoriesStore.additionsCategory.categoryId,
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
                  return _buildProductCard(product, cartStore);
                },
              ),
              Positioned(
                bottom: 110,
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

  Widget _buildProductCard(Product product, CartStore cartStore) {
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
            Expanded(child: _buildProductDetails(product)),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    UrlHelper.getFullImageUrl(product.photo),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : LoadingImageIndicator(
                                loadingProgress: loadingProgress,
                              ),
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/images/addition.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 50,
                  child: Observer(
                    builder: (_) {
                      final counter =
                          cartStore.counters[product.productId] ?? 0;
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
                                      ? () => cartStore.decrementCounter(
                                            product.productId,
                                          )
                                      : null,
                                ),
                                SizedBox(
                                  width: 20,
                                  child: Text(
                                    '$counter',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          CustomIconButton(
                            icon: Icons.add,
                            onPressed: () =>
                                cartStore.incrementCounter(product.productId),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetails(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.productName, style: TextStyles.categoriesText),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${product.productName}\n',
                        style: TextStyles.categoriesText,
                      ),
                      WidgetSpan(
                        child: SizedBox(height: 12),
                      ),
                      const TextSpan(
                        text: 'виберіть від 1 варіанту',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: product.ingredients.map((ing) {
                      final subText = "${ing.brutto.toStringAsFixed(0)} г, ${ing.price.toStringAsFixed(0)} грн";
                      return CheckboxListTile(
                        value: true,
                        onChanged: null, // Чекбокси наразі неактивні
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ing.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,),),
                            Text(subText,
                                style: const TextStyle(color: Colors.grey),),
                          ],
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Закрити'),
                  ),
                ],
              ),
            );
          },
          child: const Text('+ Вибрати'),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Ціна: ', style: TextStyles.habitKeyText),
              TextSpan(
                text: '${(product.price / 100).toStringAsFixed(0)} грн',
                style: TextStyles.authText,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget _buildProductDetails(Product product) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(product.productName, style: TextStyles.categoriesText),
//       const SizedBox(height: 4),
//       RichText(
//         text: TextSpan(
//           children: [
//             TextSpan(text: 'Інгредієнти: ', style: TextStyles.habitKeyText),
//             TextSpan(
//               text: product.ingredients.map((ing) {
//                 String text = ing.name;
//                 if (ing.subIngredients.isNotEmpty) {
//                   text +=
//                       " (${ing.subIngredients.map((s) => s.name).join(', ')})";
//                 }
//                 if (product.categoryName == "Добавки") {
//                   text += " [${ing.brutto} г, ${ing.price} грн]";
//                 }
//                 print('Перелік добавок: $text');
//                 return text;
//               }).join(', '),
//               style: TextStyles.spanKeyText,
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(height: 8),
//       RichText(
//         text: TextSpan(
//           children: [
//             TextSpan(text: 'Ціна: ', style: TextStyles.habitKeyText),
//             TextSpan(
//               text: '${(product.price / 100).toStringAsFixed(0)} грн',
//               style: TextStyles.authText,
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
