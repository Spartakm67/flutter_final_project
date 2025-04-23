import 'package:flutter/material.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';
import 'package:flutter_final_project/services/url_helper.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter_final_project/presentation/widgets/loading_image_indicator.dart';
import 'package:flutter_final_project/presentation/screens/additions_screen.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/domain/store/categories_store/categories_store.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final String categoryId;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context, listen: false);

    final categoriesStore = Provider.of<CategoriesStore>(context, listen: false);
    final productStore = Provider.of<ProductStore>(context, listen: false);

    return Scaffold(
      // appBar: AppBar(title: Text(product.productName)),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, categoryId); // ← передаємо categoryId назад
          },
        ),
        title: Text(product.productName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 4 / 3.5,
                  child: Hero(
                    tag: 'product-${product.productId}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        UrlHelper.getFullImageUrl(product.photo),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return LoadingImageIndicator(
                            loadingProgress: loadingProgress,
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/default_image.webp',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.productName,
              style: TextStyles.categoriesText,
            ),
            const SizedBox(height: 16),
            Text(
              'Ціна: ${(product.price / 100).toStringAsFixed(0)} грн\n',
              style: TextStyles.authText,
            ),
            // const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.ingredients.map((i) => i.name).join(", "),
                style: TextStyles.habitKeyText,
                textAlign: TextAlign.justify,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
            const SizedBox(height: 24),
             Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Observer(
                  //   builder: (_) {
                  //     return SizedBox(
                  //       width: MediaQuery.of(context).size.width * 0.6,
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           final additionsCategory = categoriesStore.additionsCategory;
                  //           // print('Категорія добавки:   id = ${additionsCategory.categoryId}, name = ${additionsCategory.categoryName}');
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (_) => AdditionsScreen(
                  //                 // cartStore: cartStore,
                  //                 productStore: productStore,
                  //                 categoriesStore: categoriesStore,
                  //                 categoryId: additionsCategory.categoryId,
                  //                 categoryName: additionsCategory.categoryName,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: Colors.blueAccent,
                  //           foregroundColor: Colors.white,
                  //           padding: const EdgeInsets.symmetric(vertical: 12),
                  //           textStyle: const TextStyle(fontSize: 16),
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(12),
                  //           ),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(horizontal: 12),
                  //           child: const Text(
                  //             "Вибрати добавки",
                  //             style: TextStyle(
                  //               fontSize: 17, color: Colors.white,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  const SizedBox(height: 24),
                  Observer(
                    builder: (_) {
                      return ElevatedButton(
                        onPressed: () {
                          cartStore.incrementCounter(product.productId);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24,),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor:
                              Colors.black.withAlpha((0.5 * 255).toInt()),
                        ),
                        child: Text(
                          'Додати до замовлення за ${(product.price / 100).toStringAsFixed(0)} грн',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white,),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Center(
//   child: Observer(
//     builder: (_) {
//       return ElevatedButton(
//         onPressed: () {
//           cartStore.incrementCounter(
//             product.productId,
//           );
//           Navigator.pop(context);
//         },
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(
//             vertical: 12,
//             horizontal: 24,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           backgroundColor: Colors.black.withAlpha((0.5 * 255).toInt()),
//         ),
//         child: Text(
//           'Додати до замовлення за ${(product.price / 100).toStringAsFixed(0)} грн',
//           style: const TextStyle(fontSize: 18, color: Colors.white,),
//           textAlign: TextAlign.center,
//         ),
//       );
//     },
//   ),
// ),

// onPressed: () async {
//   try {
//     final category = await AdditionsApiService.fetchAdditionsCategory();
//
//     if (context.mounted) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => AdditionsScreen(
//             categoriesStore: categoriesStore,
//             productStore: productStore,
//             categoryId: int.parse(category.categoryId),
//             categoryName: category.categoryName,
//           ),
//         ),
//       );
//     }
//   } catch (e) {
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Не вдалося завантажити добавки: $e')),
//       );
//     }
//   }
// },