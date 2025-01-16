import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/services/working_hours_helper.dart';
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
  late AuthStore authStore;

  @override
  void initState() {
    super.initState();
    cartStore = Provider.of<CartStore>(context, listen: false);
    orderStore = Provider.of<OrderStore>(context, listen: false);
    authStore = Provider.of<AuthStore>(context, listen: false);

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

  bool _isWorkingHours() {
    return WorkingHoursHelper.isWorkingHours();
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
                    Visibility(
                        visible: cartStore.cartItems.isNotEmpty,
                      child: ElevatedButton(
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
    await _updateUserDataIfNeeded(orderModel);
    orderStore.validatePhoneNumber(orderModel.phone);

        if (!orderStore.isPhoneNumberValid) {
          throw Exception('Невірний формат номера телефону');
        }

        if (orderModel.name == null || orderModel.name.trim().isEmpty) {
          throw Exception('Ім’я не може бути порожнім');
        }
        if (orderModel.name.length < 2) {
          throw Exception('Ім’я повинно містити принаймні 2 символи.');
        }

        final nameRegExp = RegExp(r'^[a-zA-Zа-яА-ЯёЁіІїЇєЄґҐ\s]+$');
        if (!nameRegExp.hasMatch(orderModel.name)) {
        throw Exception(
        'Ім’я може містити лише літери та пробіли.',);
        }

        if (isDelivery && (orderModel.address?.trim().isEmpty ?? true)) {
          throw Exception('Адреса для доставки не може бути порожньою');
        }
        if (orderModel.address!.trim().length < 5) {
          throw Exception('Адреса повинна містити принаймні 5 символів.');
        }
        if (orderModel.address!.trim().length > 100) {
          throw Exception('Адреса не може перевищувати 100 символів.');
        }

        final addressRegExp =
        RegExp(r'^[a-zA-Zа-яА-ЯёЁіІїЇєЄґҐ0-9\s,.\-/\\]+$');
        if (!addressRegExp.hasMatch(orderModel.address!)) {
          throw Exception(
              'Адреса може містити лише літери, цифри, пробіли, коми, крапки, дефіси, а також "/" або "\\".',);
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
      throw Exception('Замовлення повинно містити хоча б один продукт');
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
    final navigator = Navigator.of(context);

    try {
      final orderModel = orderStore.currentOrder;
      final counters = cartStore.counters;
      final comment = cartStore.comment;

      if (orderModel == null || counters.isEmpty) {
          CustomSnackBar.show(
          context: context,
          message: 'Замовлення відсутнє!',
          backgroundColor: Colors.orangeAccent,
          position: SnackBarPosition.top,
          duration: const Duration(seconds: 5),
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
      print('Респонс: $responseData');
      final orderId = responseData?['incoming_order_id']?.toString();
      final statusId = responseData?['status'];
      final checkId = responseData?['transaction_id']?.toString();

      if (!mounted) return;

      if (_isWorkingHours()) {
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
      }
      navigator.pop();

      if (mounted) {
        CustomDialog.show(
          context: context,
          builder: (_) => _isWorkingHours()
              ? OrderStatusWidget(
            orderId: orderId,
            statusId: statusId,
            checkId: checkId,
            onCartClear: () async {
              if ((statusId != null && checkId != null) || orderId != null) {
                await cartStore.clearCart();
              }
            },
          )
              : OrderStatusWidget(
            orderId: orderId,
            statusId: statusId,
            checkId: checkId,
            onCartClear: () async {
              if ((statusId != null && checkId != null) || orderId != null) {
                await cartStore.clearCart();
              }
            },
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      CustomSnackBar.show(
        context: context,
        message: 'Замовлення не відправлене: $errorMessage',
        backgroundColor: Colors.redAccent,
        position: SnackBarPosition.top,
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> _updateUserDataIfNeeded(OrderModelHive orderModel) async {
    if (authStore.currentUser != null) {
      final userId = authStore.currentUser!.uid;

      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      final userData = userDoc.data();

      final updates = <String, dynamic>{};
      if (userData != null) {
        if (userData['phoneNumber'] != orderModel.phone.trim()) {
          updates['phoneNumber'] = orderModel.phone.trim();
        }
        if (userData['name'] != orderModel.name.trim()) {
          updates['name'] = orderModel.name.trim();
        }
        if (orderModel.address != null &&
            userData['address'] != orderModel.address!.trim()) {
          updates['address'] = orderModel.address!.trim();
        }

        if (updates.isNotEmpty) {
          await authStore.updateUserData(userId, updates);
        }
      }
    }
  }

}
