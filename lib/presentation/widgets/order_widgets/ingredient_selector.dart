import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

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

    return AlertDialog(
      title: RichText(
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
      content: SingleChildScrollView(
        child: Column(
          children: product.ingredients.map((ing) {
            final subText =
                "${ing.brutto.toStringAsFixed(0)} г, ${ing.price.toStringAsFixed(0)} грн";
            final isSelected = _selectedIngredients[ing.name] ?? false;

            return Observer(
              builder: (_) {
                final count = cartStore.getIngredientCount(
                    product.productId, ing.name,);

                return CheckboxListTile(
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      _selectedIngredients[ing.name] = value ?? false;

                      if (value == true) {
                        // Додаємо 1 при першому виборі
                        cartStore.incrementIngredient(
                            product.productId, ing.name, ing.price,);
                      } else {
                        // Якщо зняли галочку — обнуляємо кількість
                        while (cartStore.getIngredientCount(
                            product.productId, ing.name,) >
                            0) {
                          cartStore.decrementIngredient(
                              product.productId, ing.name, ing.price,);
                        }
                      }
                    });
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ing.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        subText,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  secondary: isSelected
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cartStore.decrementIngredient(
                              product.productId, ing.name, ing.price,);
                          setState(() {});
                        },
                      ),
                      Text('$count'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartStore.incrementIngredient(
                              product.productId, ing.name, ing.price,);
                          setState(() {});
                        },
                      ),
                    ],
                  )
                      : null,
                );
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        Observer(
          builder: (_) {
            final checkSum =
            cartStore.getCheckSumForProduct(product.productId);
            return Padding(
              padding: const EdgeInsets.only(left: 16),
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
    );
  }
}

// class IngredientSelector extends StatelessWidget {
//   final String productId;
//   final List<Ingredient> ingredients;
//   final CartStore cartStore;
//
//   const IngredientSelector({
//     super.key,
//     required this.productId,
//     required this.ingredients,
//     required this.cartStore,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Оберіть інгредієнти'),
//       content: SizedBox(
//         width: double.maxFinite,
//         child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: ingredients.length,
//           itemBuilder: (context, index) {
//             final ingredient = ingredients[index];
//             return Observer(
//               builder: (_) {
//                 final count = cartStore.getIngredientCount(productId, ingredient.name);
//                 return ListTile(
//                   title: Text(ingredient.name),
//                   subtitle: Text('${ingredient.price.toStringAsFixed(2)} ₴'),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.remove),
//                         onPressed: () {
//                           cartStore.decrementIngredient(
//                             productId,
//                             ingredient.name,
//                             ingredient.price,
//                           );
//                         },
//                       ),
//                       Text('$count'),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {
//                           cartStore.incrementIngredient(
//                             productId,
//                             ingredient.name,
//                             ingredient.price,
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       actions: [
//         Observer(
//           builder: (_) {
//             final checkSum = cartStore.getCheckSumForProduct(productId);
//             return Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: Text(
//                 'Сума: ${checkSum.toStringAsFixed(2)} ₴',
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             );
//           },
//         ),
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text('OK'),
//         ),
//       ],
//     );
//   }
// }



