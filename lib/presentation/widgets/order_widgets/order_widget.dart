import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/presentation/widgets/custom_container.dart';
import 'package:flutter_final_project/presentation/widgets/custom_text_field.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/alert_not_work.dart';
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
                    const SizedBox(
                      height: 8,
                    ),
                    Text(_isDelivery ? 'Доставлення' : 'Самовивіз'),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: _isDelivery
                                  ? Colors.black.withAlpha(200)
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.black.withAlpha(200),
                                width: 2.0,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() => _isDelivery = true);
                              },
                              borderRadius:
                                  BorderRadius.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10.0,
                                ),
                                child: Text(
                                  'Доставлення',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _isDelivery
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: !_isDelivery
                                  ? Colors.black.withAlpha(200)
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.black.withAlpha(200),
                                width: 2.0,
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() => _isDelivery = false);
                              },
                              borderRadius:
                                  BorderRadius.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10.0,
                                ),
                                child: Text(
                                  'Самовивіз',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: !_isDelivery
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
