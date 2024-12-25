import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';
import 'package:flutter_final_project/presentation/widgets/custom_container.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/delivery_option_container.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/alert_not_work.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/time_picker_field.dart';
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

  CartStore? cartStore;
  bool _isInitialized = false;
  late bool _isDelivery;
  late bool _isCash;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      cartStore = Provider.of<CartStore>(context, listen: false);
      // nameController = TextEditingController(text: cartStore?.userName ?? '');
      nameController = TextEditingController();
      phoneController = TextEditingController();
      addressController = TextEditingController();
      _isInitialized = true;
      _isDelivery = true;
      _isCash = true;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final orderStore = Provider.of<OrderStore>(context, listen: false);
    return Scaffold(
      body: Form(
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
              return const Center(
                child: Text(
                  'Корзина пуста!',
                  style: TextStyles.greetingsText,
                ),
              );
            }
            return Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomContainer(
                      backgroundColor: Colors.black.withAlpha(0),
                      padding: EdgeInsets.zero,
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Ім’я',
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Будь ласка, введіть ім’я';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Телефон',
                            prefixIcon: Icon(Icons.phone),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Будь ласка, введіть номер телефону';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_isDelivery ? 'Доставлення' : 'Самовивіз'),
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
                            setState(() {
                              _isDelivery = true;
                            });
                          },
                          label: 'Доставлення',
                        ),
                        DeliveryOptionContainer(
                          isSelected: !_isDelivery,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                          ),
                          onTap: () {
                            setState(() {
                              _isDelivery = false;
                            });
                          },
                          label: 'Самовивіз',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CustomContainer(
                      backgroundColor: Colors.black.withAlpha(0),
                      padding: EdgeInsets.zero,
                      children: [
                        TextFormField(
                          controller: addressController,
                          decoration: const InputDecoration(
                            labelText: 'Вкажіть адресу доставлення',
                            prefixIcon: Icon(Icons.location_on),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Будь ласка, введіть адресу';
                            }
                            return null;
                          },
                        ),
                        TimePickerField(
                          orderStore: orderStore,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_isCash ? 'Оплата готівкою' : 'Оплата карткою'),
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
                            setState(() {
                              _isCash = true;
                            });
                          },
                          label: 'Готівкою',
                        ),
                        DeliveryOptionContainer(
                          isSelected: !_isCash,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                          ),
                          onTap: () {
                            setState(() {
                              _isCash = false;
                            });
                          },
                          label: 'Карткою',
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
    );
  }
}
