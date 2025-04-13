import 'package:flutter/material.dart';
import 'package:flutter_final_project/services/url_helper.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: TextStyles.categoriesText,
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Інгредієнти: ',
                          style: TextStyles.habitKeyText,
                        ),
                        TextSpan(
                          text: product.ingredients.map((ing) {
                            String ingredientText = ing.name;
                            if (ing.subIngredients.isNotEmpty) {
                              ingredientText += " (${ing.subIngredients
                                      .map((sub) => sub.name)
                                      .join(', ')})";
                            }
                            ingredientText +=
                            " [${ing.brutto} г, ${ing.price} грн]";
                            return ingredientText;
                          }).join(', '),
                          style: TextStyles.spanKeyText,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Ціна: ',
                          style: TextStyles.habitKeyText,
                        ),
                        TextSpan(
                          text:
                          '${(product.price / 100).toStringAsFixed(0)} грн',
                          style: TextStyles.authText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                UrlHelper.getFullImageUrl(product.photo),
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  'assets/images/default_image.webp',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
