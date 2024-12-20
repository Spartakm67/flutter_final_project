import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/services/url_helper.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/presentation/widgets/loading_image_indicator.dart';

class CartPreviewScreen extends StatelessWidget {
  const CartPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Вибрані товари'),
      ),
      body: Observer(
        builder: (_) {
          final items = cartStore.cartItems;
          final itemsLength = items.length;

          if (items.isEmpty) {
            return const Center(
              child: Text('Корзина пуста!'),
            );
          }
          return Scrollbar(
            thickness: 8.0,
            radius: const Radius.circular(10),
            thumbVisibility: true,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = items[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                UrlHelper.getFullImageUrl(product.photo!),
                                width: 50,
                                height: 50,
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
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/default_image.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            title: Text(product.productName),
                            subtitle: Text(
                              'Ціна: ${(product.price / 100).toStringAsFixed(0)} грн',
                            ),
                            trailing: SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Observer(
                                    builder: (_) {
                                      final counter = cartStore
                                          .getItemCount(product.productId);
                                      return Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: counter > 0
                                                ? () {
                                                    cartStore.decrementCounter(
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
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 4),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      cartStore
                                          .incrementCounter(product.productId);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (index < itemsLength - 1)
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16,
                            ),
                        ],
                      );
                    },
                    childCount: itemsLength,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
