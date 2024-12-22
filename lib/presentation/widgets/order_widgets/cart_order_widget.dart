import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/services/url_helper.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/presentation/widgets/loading_image_indicator.dart';
import 'package:flutter_final_project/presentation/widgets/custom_add_icon_button.dart';
import 'package:flutter_final_project/presentation/widgets/custom_text_field.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

class CartOrderWidget extends StatefulWidget {
  const CartOrderWidget({super.key});

  @override
  State<CartOrderWidget> createState() => _CartOrderWidgetState();
}

class _CartOrderWidgetState extends State<CartOrderWidget> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  CartStore? cartStore;
  bool _isInitialized = false;

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
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
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
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: nameController,
                    labelText: 'Ім’я',
                    prefixIcon: Icons.person,
                  ),
                  // const SizedBox(height: 2),
                  CustomTextField(
                    controller: phoneController,
                    labelText: 'Телефон',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 2),
                  CustomTextField(
                    controller: addressController,
                    labelText: 'Адреса',
                    prefixIcon: Icons.location_on,
                  ),
                  const SizedBox(height: 2),
                  ElevatedButton(
                    onPressed: () {
                      // Дії при натисканні
                    },
                    child: const Text('Надіслати'),
                  ),
                  const SizedBox(height: 2),
                  CustomTextField(
                    controller: nameController,
                    labelText: 'Коментар до замовлення',
                    prefixIcon: Icons.comment,
                    suffixIcon: Icons.delete_forever,
                    onSuffixIconPressed: () {
                      nameController.clear();
                      cartStore!.saveCommentToHive('');
                    },
                    onChanged: (value) {
                      cartStore!.saveCommentToHive(value);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
