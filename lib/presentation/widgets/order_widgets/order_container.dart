import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/presentation/widgets/custom_dialog.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:flutter_final_project/data/models/poster/incoming_order.dart';
import 'package:flutter_final_project/data/models/hive/order_model_hive.dart';
import 'package:flutter_final_project/services/poster_api/create_incoming_order.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/order_widget.dart';
import 'package:flutter_final_project/presentation/widgets/custom_snack_bar.dart';
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
                        await _handleOrder();
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
    required bool isDelivery,
    required TimeOfDay selectedTime,
  }) async {
        if (!orderStore.isPhoneNumberValid) {
          CustomSnackBar.show(
            context: context,
            message: 'Невірний формат номера телефону',
            backgroundColor: Colors.redAccent,
            position: SnackBarPosition.top,
            duration: const Duration(seconds: 5),
          );
          throw Exception('Невірний формат номера телефону');
        }

        final products = counters.entries
        .where((entry) => entry.value > 0)
        .map((entry) {
      return Product(
        productId: entry.key,
        count: entry.value,
      );
    }).toList();

    if (products.isEmpty) {
      throw Exception('Order must contain at least one product with a positive quantity');
    }
        final serviceMode = isDelivery ? 3 : 2;
        final deliveryPrice = isDelivery ? 5000 : 0;

        final now = DateTime.now();
        final deliveryDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        final deliveryTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(deliveryDateTime);

    return IncomingOrder(
      spotId: 1,
      point: orderModel.point,
      phone: orderModel.phone,
      address: isDelivery ? orderModel.address : orderModel.point,
      products: products,
      comment: comment,
      paymentMethod: orderModel.paymentMethod,
      serviceMode: serviceMode,
      deliveryPrice: deliveryPrice,
      deliveryTime: deliveryTime,
    );
  }

  Future<void> _handleOrder() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      final orderModel = orderStore.currentOrder;
      final counters = cartStore.counters;
      final comment = cartStore.comment;

      if (orderModel == null || counters.isEmpty) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Order data or cart is missing')),
        );
        return;
      }

      final incomingOrder = await createIncomingOrderFromHive(
        orderModel: orderModel,
        counters: counters,
        comment: comment ?? '',
        isDelivery: orderStore.isDelivery,
        selectedTime: orderStore.selectedTime,
      );

      final jsonOrder = incomingOrder.toJson();
      print('Отправленный запрос: $jsonOrder');

      final response = await OrderApiService.sendOrder(incomingOrder);

      final Map<String, dynamic>? responseData = response['response'];
      final statusId = responseData?['status'];
      final checkId = responseData?['transaction_id']?.toString();

      if (!mounted) return;

      if (statusId == null) {
        CustomSnackBar.show(
          context: context,
          message: 'Замовлення відправлене, але ID статусу замовлення не отримано!',
          backgroundColor: Colors.orangeAccent,
          position: SnackBarPosition.top,
          duration: const Duration(seconds: 5),
        );
      } else {
        CustomSnackBar.show(
          context: context,
          message: 'Замовлення відправлене успішно!',
          backgroundColor: Colors.greenAccent,
          position: SnackBarPosition.top,
          duration: const Duration(seconds: 3),
        );
      }

      if (checkId == null) {
        CustomSnackBar.show(
          context: context,
          message: 'Замовлення відправлене, але № чеку не отримано!',
          backgroundColor: Colors.orangeAccent,
          position: SnackBarPosition.top,
          duration: const Duration(seconds: 5),
        );
      } else {
        CustomSnackBar.show(
          context: context,
          message: 'Замовлення відправлене успішно!',
          backgroundColor: Colors.greenAccent,
          position: SnackBarPosition.top,
          duration: const Duration(seconds: 3),
        );
      }

      await cartStore.clearCart();

      navigator.pop();

      if (mounted) {
        CustomDialog.show(
          context: context,
          builder: (_) => OrderStatusWidget(statusId: statusId, checkId: checkId,),
        );
      }
    } catch (e) {
      if (!mounted) return;

      CustomSnackBar.show(
        context: context,
        message: 'Failed to send order: $e',
        backgroundColor: Colors.redAccent,
        position: SnackBarPosition.top,
        duration: const Duration(seconds: 5),
      );
    }
  }
}
