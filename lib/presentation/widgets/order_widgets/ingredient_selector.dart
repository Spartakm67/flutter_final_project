import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:flutter_final_project/main.dart';

class IngredientSelector extends StatefulWidget {
  final Product product;
  final CartStore cartStore;

  const IngredientSelector({
    super.key,
    required this.product,
    required this.cartStore,
  });

  @override
  State<IngredientSelector> createState() => _IngredientSelectorState();
}

class _IngredientSelectorState extends State<IngredientSelector> {
  final Map<String, bool> _selectedIngredients = {};

  @override
  void initState() {
    super.initState();
    for (var ing in widget.product.ingredients) {
      _selectedIngredients[ing.name] = false; // Всі вимкнені за замовчуванням
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final cartStore = widget.cartStore;

    return Dialog(
      insetPadding: const EdgeInsets.all(8),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.95,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${product.productName}\n',
                      style: TextStyles.categoriesText,
                    ),
                    WidgetSpan(child: SizedBox(height: 12)),
                    const TextSpan(
                      text: 'виберіть від 1 варіанту',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: product.ingredients.map((ing) {
                      final isSelected =
                          _selectedIngredients[ing.name] ?? false;

                      return Observer(
                        builder: (_) {
                          final count = cartStore.getIngredientCount(
                            product.productId,
                            ing.name,
                          );
                          return buildIngredientRow(
                            ing: ing,
                            isSelected: isSelected,
                            count: count,
                            onChanged: (value) {
                              setState(() {
                                _selectedIngredients[ing.name] = value ?? false;
                                if (value == true) {
                                  cartStore.incrementIngredient(
                                    product.productId,
                                    ing.name,
                                    ing.price,
                                  );
                                } else {
                                  while (cartStore.getIngredientCount(
                                        product.productId,
                                        ing.name,
                                      ) >
                                      0) {
                                    cartStore.decrementIngredient(
                                      product.productId,
                                      ing.name,
                                      ing.price,
                                    );
                                  }
                                }
                              });
                            },
                            onAdd: () {
                              cartStore.incrementIngredient(
                                product.productId,
                                ing.name,
                                ing.price,
                              );
                              setState(() {});
                            },
                            onRemove: () {
                              cartStore.decrementIngredient(
                                product.productId,
                                ing.name,
                                ing.price,
                              );
                              final newCount = cartStore.getIngredientCount(
                                product.productId,
                                ing.name,
                              );
                              if (newCount == 0) {
                                setState(() {
                                  _selectedIngredients[ing.name] = false;
                                });
                              } else {
                                setState(() {});
                              }
                            },
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// ACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Observer(
                    builder: (_) {
                      final checkSum =
                          cartStore.getCheckSumForProduct(product.productId);
                      return Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          'Сума: ${checkSum.toStringAsFixed(2)} грн',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIngredientRow({
    required Ingredient ing,
    required bool isSelected,
    required int count,
    required void Function(bool?) onChanged,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ing.name, style: TextStyles.ingredientsText),
                Text(
                  "${ing.brutto.toStringAsFixed(0)} г, ${ing.price.toStringAsFixed(0)} грн",
                  style: TextStyles.userText,
                ),
              ],
            ),
          ),
          if (isSelected)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: onRemove,
                ),
                Text('$count'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: onAdd,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   final product = widget.product;
//   final cartStore = widget.cartStore;
//
//   return Dialog(
//     insetPadding: const EdgeInsets.all(8),
//     child: ConstrainedBox(
//       constraints: BoxConstraints(
//         maxWidth: screenWidth * 0.95,
//       ),
//       child: IntrinsicHeight(
//         child: AlertDialog(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
//           titlePadding: const EdgeInsets.only(top: 4, left: 1, right: 4),
//           actionsPadding: const EdgeInsets.only(bottom: 4, right: 4),
//           title: RichText(
//             textAlign: TextAlign.start,
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: '${product.productName}\n',
//                   style: TextStyles.categoriesText,
//                 ),
//                 WidgetSpan(child: SizedBox(height: 12)),
//                 const TextSpan(
//                   text: 'виберіть від 1 варіанту',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: product.ingredients.map((ing) {
//                final isSelected = _selectedIngredients[ing.name] ?? false;
//
//                 return Observer(
//                   builder: (_) {
//                     final count = cartStore.getIngredientCount(
//                       product.productId,
//                       ing.name,
//                     );
//                     return buildIngredientRow(
//                       ing: ing,
//                       isSelected: isSelected,
//                       count: count,
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedIngredients[ing.name] = value ?? false;
//                           if (value == true) {
//                             cartStore.incrementIngredient(
//                               product.productId,
//                               ing.name,
//                               ing.price,
//                             );
//                           } else {
//                             while (cartStore.getIngredientCount(
//                               product.productId,
//                               ing.name,
//                             ) > 0) {
//                               cartStore.decrementIngredient(
//                                 product.productId,
//                                 ing.name,
//                                 ing.price,
//                               );
//                             }
//                           }
//                         });
//                       },
//                       onAdd: () {
//                         cartStore.incrementIngredient(
//                           product.productId,
//                           ing.name,
//                           ing.price,
//                         );
//                         setState(() {});
//                       },
//                       onRemove: () {
//                         cartStore.decrementIngredient(
//                           product.productId,
//                           ing.name,
//                           ing.price,
//                         );
//                         final newCount = cartStore.getIngredientCount(
//                           product.productId,
//                           ing.name,
//                         );
//                         if (newCount == 0) {
//                           setState(() {
//                             _selectedIngredients[ing.name] = false;
//                           });
//                         } else {
//                           setState(() {});
//                         }
//                       },
//                     );
//                   },
//                 );
//
//
//               }).toList(),
//             ),
//           ),
//           actions: [
//             Observer(
//               builder: (_) {
//                 final checkSum =
//                 cartStore.getCheckSumForProduct(product.productId);
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 16),
//                   child: Text(
//                     'Сума: ${checkSum.toStringAsFixed(2)} грн',
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 );
//               },
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
//




// final screenWidth = MediaQuery.of(context).size.width;

// final subText =
//     "${ing.brutto.toStringAsFixed(0)} г, ${ing.price.toStringAsFixed(0)} грн";

// return Observer(
//   builder: (_) {
//     final count = cartStore.getIngredientCount(
//       product.productId,
//       ing.name,
//     );
//
//     return CheckboxListTile(
//       contentPadding: EdgeInsets.zero,
//       controlAffinity: ListTileControlAffinity.leading,
//       value: isSelected,
//       onChanged: (value) {
//         setState(() {
//           _selectedIngredients[ing.name] = value ?? false;
//
//           if (value == true) {
//             cartStore.incrementIngredient(
//               product.productId,
//               ing.name,
//               ing.price,
//             );
//           } else {
//             while (cartStore.getIngredientCount(
//               product.productId,
//               ing.name,
//             ) >
//                 0) {
//               cartStore.decrementIngredient(
//                 product.productId,
//                 ing.name,
//                 ing.price,
//               );
//             }
//           }
//         });
//       },
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             ing.name,
//             style: TextStyles.ingredientsText,
//           ),
//           Text(
//             subText,
//             style: TextStyles.userText,
//           ),
//         ],
//       ),
//       secondary: isSelected
//           ? Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.remove),
//             onPressed: () {
//               cartStore.decrementIngredient(
//                 product.productId,
//                 ing.name,
//                 ing.price,
//               );
//               final newCount =
//               cartStore.getIngredientCount(
//                   product.productId, ing.name,);
//
//               if (newCount == 0) {
//                 setState(() {
//                   _selectedIngredients[ing.name] = false;
//                 });
//               } else {
//                 setState(() {});
//               }
//             },
//           ),
//           Text('$count'),
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () {
//               cartStore.incrementIngredient(
//                 product.productId,
//                 ing.name,
//                 ing.price,
//               );
//               setState(() {});
//             },
//           ),
//         ],
//       )
//           : null,
//     );
//   },
// );
