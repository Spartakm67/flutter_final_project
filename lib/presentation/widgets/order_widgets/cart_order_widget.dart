import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/presentation/widgets/custom_container.dart';
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Будь ласка, введіть номер телефону';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        labelText: 'Адреса',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Будь ласка, введіть адресу';
                        }
                        return null;
                      },
                    ),
                    CustomContainer(
                      backgroundColor: Colors.black.withAlpha(30),
                      children: const [
                        Text(
                          'Вартість доставлення 50 грн.\nДоставимо безкоштовно при замовленні від 250 грн.',
                          style: TextStyles.cartText,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Observer(
//       builder: (_) {
//         if (cartStore == null) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//
//         final items = cartStore!.cartItems;
//         if (items.isEmpty) {
//           return const Center(
//             child: Text(
//               'Корзина пуста!',
//               style: TextStyles.greetingsText,
//             ),
//           );
//         }
//
//         return Scrollbar(
//           thumbVisibility: true,
//           child: SingleChildScrollView(
//             // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomTextField(
//                   controller: nameController,
//                   labelText: 'Ім’я',
//                   prefixIcon: Icons.person,
//                   decoration: const InputDecoration(
//                     contentPadding: EdgeInsets.zero,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 4,),
//                 CustomTextField(
//                   controller: phoneController,
//                   labelText: 'Телефон',
//                   prefixIcon: Icons.phone,
//                   keyboardType: TextInputType.phone,
//                   decoration: const InputDecoration(
//                     contentPadding: EdgeInsets.zero,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 CustomTextField(
//                   controller: addressController,
//                   labelText: 'Адреса',
//                   prefixIcon: Icons.location_on,
//                 ),
//                 const SizedBox(height: 2),
//
//                 const SizedBox(height: 2),
//                 CustomTextField(
//                   controller: nameController,
//                   labelText: 'Коментар до замовлення',
//                   prefixIcon: Icons.comment,
//                   suffixIcon: Icons.delete_forever,
//                   onSuffixIconPressed: () {
//                     nameController.clear();
//                     cartStore!.saveCommentToHive('');
//                   },
//                   onChanged: (value) {
//                     cartStore!.saveCommentToHive(value);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }
}
