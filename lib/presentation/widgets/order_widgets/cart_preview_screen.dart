import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';

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

          if (items.isEmpty) {
            return const Center(
              child: Text('Корзина пуста!'),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              final counter = cartStore.getItemCount(product.productId);

              return ListTile(
                leading: product.photo != null
                    ? Image.network(
                  product.photo!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : const Icon(Icons.image_not_supported),
                title: Text(product.productName),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: SizedBox(
                  height: 50,
                  child: Row(
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
                                cartStore.decrementCounter(product.productId);
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
                      const SizedBox(width: 4),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartStore.incrementCounter(product.productId);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}