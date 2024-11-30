import 'package:flutter/material.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/domain/store/scroll_store/scroll_store.dart';
import 'package:flutter_final_project/presentation/screens/category_detail_screen.dart';
import 'package:flutter_final_project/presentation/widgets/scroll_to_top_button.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.productName)),
      body: Column(
        children: [
          Hero(
            tag: product.productId,
            child: Image.network(product.photoOrigin),
          ),
          Text(product.productName),
          Text('Price: ${product.price.toStringAsFixed(2)}'),
          Text('Ingredients: ${product.ingredients.map((i) => i.name).join(", ")}'),
        ],
      ),
    );
  }
}
