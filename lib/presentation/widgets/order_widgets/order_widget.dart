import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/presentation/widgets/custom_container.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/delivery_option_container.dart';
import 'package:flutter_final_project/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/alert_not_work.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/time_picker_field.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/point_picker_field.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/time_point_picker_field.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  late AuthStore authStore;
  late OrderStore orderStore;
  CartStore? cartStore;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      cartStore = Provider.of<CartStore>(context, listen: false);
      orderStore = Provider.of<OrderStore>(context, listen: false);
      authStore = Provider.of<AuthStore>(context, listen: false);
      nameController = TextEditingController();
      phoneController = TextEditingController();
      addressController = TextEditingController();

      orderStore.loadOrder();
      final currentOrder = orderStore.currentOrder;

      if (currentOrder != null) {
        nameController.text = currentOrder.name;
        phoneController.text = currentOrder.phone;
        addressController.text = currentOrder.address ?? '';
      }

      _isInitialized = true;
    }
  }

  bool get _isDelivery => orderStore.isDelivery;
  bool get _isCash => orderStore.isCash;
  FocusNode phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    phoneFocusNode.addListener(() {
      if (!phoneFocusNode.hasFocus) {
        orderStore.validatePhoneNumber(phoneController.text);

        if (!orderStore.isPhoneNumberValid) {
          CustomSnackBar.show(
            context: context,
            message: 'Невірний формат номера телефону',
            backgroundColor: Colors.redAccent,
            position: SnackBarPosition.top,
            duration: const Duration(seconds: 3),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _formKey,
          child: Observer(
            builder: (_) {
              if (cartStore == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final items = cartStore!.cartItems;
              if (items.isEmpty) {
                return Center(
                  child: Text(
                    'Корзина пуста!',
                    style: TextStyles.greetingsText,
                  ),
                );
              }
              return Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      CustomContainer(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        children: [
                          TextFormField(
                            controller: nameController,
                            // autofocus: true,
                            decoration: InputDecoration(
                              labelText:
                                  nameController.text.isEmpty ? 'Ім’я' : null,
                              prefixIcon: const Icon(Icons.person),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0,),
                            ),
                            onChanged: _onNameChanged,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Будь ласка, введіть ім’я';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: phoneController,
                            focusNode: phoneFocusNode,
                            decoration: InputDecoration(
                              labelText: phoneController.text.isEmpty
                                  ? 'Номер телефону'
                                  : null,
                              prefixIcon: const Icon(Icons.phone_android),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0,),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              if (!value.startsWith('+380')) {
                                phoneController.text = '+380';
                                phoneController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(
                                      offset: phoneController.text.length,),
                                );
                              } else {
                                _onPhoneChanged(value);
                              }
                            },
                            keyboardType: TextInputType.phone,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(_isDelivery ? 'Доставка' : 'Самовивіз'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          DeliveryOptionContainer(
                            isSelected: _isDelivery,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                            ),
                            onTap: () {
                              orderStore.updateDelivery(true);
                            },
                            label: 'Доставка',
                            excludeRightBorder: true,
                          ),
                          DeliveryOptionContainer(
                            isSelected: !_isDelivery,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                            onTap: () {
                              orderStore.updateDelivery(false);
                            },
                            label: 'Самовивіз',
                            excludeLeftBorder: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_isDelivery)
                        const Text(
                            'Вкажіть адресу, під\'їзд, поверх, квартиру (офіс) та виберіть час:',),
                      const SizedBox(height: 8),
                      CustomContainer(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        children: [
                          if (_isDelivery)
                            TextFormField(
                              controller: addressController,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: addressController.text.isEmpty
                                    ? 'Вкажіть адресу'
                                    : null,
                                prefixIcon: const Icon(Icons.location_on),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0,),
                              ),
                              onChanged: _onAddressChanged,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Будь ласка, введіть адресу';
                                }
                                return null;
                              },
                            ),
                          if (!_isDelivery)
                            PointPickerField(orderStore: orderStore),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                            height: 1.0,
                          ),
                          if (_isDelivery)
                            TimePickerField(orderStore: orderStore),
                          if (!_isDelivery)
                            TimePointPickerField(orderStore: orderStore),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(_isCash
                          ? 'Оплата готівкою'
                          : 'Оплата карткою при отриманні',),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          DeliveryOptionContainer(
                            isSelected: _isCash,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                            ),
                            onTap: () {
                              orderStore.updatePaymentMethod(true);
                            },
                            label: 'Готівкою',
                            excludeRightBorder: true,
                          ),
                          DeliveryOptionContainer(
                            isSelected: !_isCash,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                            onTap: () {
                              orderStore.updatePaymentMethod(false);
                            },
                            label: 'Карткою',
                            excludeLeftBorder: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const AlertNotWork(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onNameChanged(String value) {
    orderStore.updateOrder(name: value.trim());
  }

  void _onPhoneChanged(String value) {
    orderStore.updateOrder(phone: value.trim());
  }

  void _onAddressChanged(String value) {
    if (_isDelivery) {
      orderStore.updateOrder(address: value.trim());
    }
  }
}
