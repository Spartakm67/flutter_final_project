import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/services/get_item_text.dart';
import 'package:flutter_final_project/presentation/widgets/custom_dialog.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:flutter_final_project/data/models/poster/incoming_order.dart';
import 'package:flutter_final_project/data/models/hive/order_model_hive.dart';
import 'package:flutter_final_project/services/poster_api/create_incoming_order.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/order_widget.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/order_status_widget.dart';

class OrderContainer extends StatefulWidget {
  const OrderContainer({super.key});

  @override
  State<OrderContainer> createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
  bool _isVisible = false;
  late CartStore cartStore;
  late OrderStore orderStore;

  @override
  void initState() {
    super.initState();
    cartStore = Provider.of<CartStore>(context, listen: false);
    orderStore = Provider.of<OrderStore>(context, listen: false);

    Future.delayed(Duration.zero, () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  void _closeWidget() {
    setState(() {
      _isVisible = false;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final cartStore = Provider.of<CartStore>(context, listen: false);
    // final orderStore = Provider.of<OrderStore>(context, listen: false);
    return Center(
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          onPressed: _closeWidget,
                        ),
                        const Text(
                          'Замовлення',
                          style: TextStyles.oderAppBarText,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: OrderWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    Observer(
                      builder: (_) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // const Spacer(),
                          Text(
                            'Сума замовлення: ${cartStore.totalCombinedOrderPrice.toStringAsFixed(0)} грн',
                            style: TextStyles.cartBottomText,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (orderStore.isDelivery)
                            Text(
                              'Доставлення: ${cartStore.deliveryPrice.toStringAsFixed(0)} грн.',
                              style: TextStyles.cartBottomText,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (!mounted) return;
                        await _handleOrder(); // Викликаємо асинхронну функцію

                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 40,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.black.withAlpha(200),
                      ),
                      child: Observer(
                        builder: (_) => Text(
                          'Оформити за ${cartStore.finalOrderPrice.toStringAsFixed(0)} грн.',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<IncomingOrder> createIncomingOrderFromHive({
    required OrderModelHive orderModel,
    required ObservableMap<String, int> counters,
    required String comment,
  }) async {
    // Фільтруємо продукти з позитивною кількістю
    final products = counters.entries
        .where((entry) => entry.value > 0) // Перевіряємо, що кількість більша за 0
        .map((entry) {
      return Product(
        productId: entry.key, // ID товару
        count: entry.value,  // Кількість товару
      );
    }).toList();

    // Перевірка, чи є хоча б один продукт
    if (products.isEmpty) {
      throw Exception('Order must contain at least one product with a positive quantity');
    }

    return IncomingOrder(
      point: orderModel.point,
      phone: orderModel.phone,
      address: orderModel.address,
      products: products,
      comment: comment,
      paymentMethod: orderModel.paymentMethod,
    );
  }


  Future<void> _handleOrder() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context); // Отримуємо посилання ДО асинхронного виклику

    try {
      // Отримуємо дані замовлення
      final orderModel = orderStore.currentOrder;
      final counters = cartStore.counters;
      final comment = cartStore.comment;

      if (orderModel == null || counters.isEmpty) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Order data or cart is missing')),
        );
        return;
      }

      // Створюємо IncomingOrder
      final incomingOrder = await createIncomingOrderFromHive(
        orderModel: orderModel,
        counters: counters,
        comment: comment ?? '',
      );

      // Відправляємо замовлення через API
      await OrderApiService.sendOrder(incomingOrder);

      // Перевіряємо, чи віджет ще у дереві
      if (!mounted) return;

      // Відображення успішного повідомлення
      messenger.showSnackBar(
        const SnackBar(content: Text('Order sent successfully!')),
      );

      // Закриваємо сторінку
      navigator.pop();

      // Після успішного відправлення відкриваємо діалогове вікно
      if (mounted) {
        CustomDialog.show(
          context: context,
          builder: (_) => const OrderStatusWidget(),
        );
      }
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to send order: $e')),
      );
    }
  }

}
