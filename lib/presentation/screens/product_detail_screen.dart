import 'package:flutter/material.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';
import 'package:flutter_final_project/services/url_helper.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/scroll_store/scroll_store.dart';
import 'package:flutter_final_project/presentation/widgets/loading_image_indicator.dart';
import 'package:flutter_final_project/presentation/widgets/scroll_to_top_button.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.productName)),
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
                        loadingBuilder:
                            (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return LoadingImageIndicator(loadingProgress: loadingProgress);
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/default_image.png',
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
            Text(product.productName),
            const SizedBox(height: 16),
            Text('Ціна: ${(product.price / 100).toStringAsFixed(2)} грн\n'),
            const SizedBox(height: 16),
            Text('Інгредієнти: ${product.ingredients.map((i) => i.name).join(", ")}',),
          ],
        ),
      ),
    );
  }
}
