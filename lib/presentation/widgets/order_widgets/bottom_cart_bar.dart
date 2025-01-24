import 'package:flutter/material.dart';
import 'package:flutter_final_project/services/get_item_text.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

class BottomCartBar extends StatelessWidget {
  final int totalItems;
  final double totalPrice;
  final VoidCallback onOrder;

  const BottomCartBar({
    super.key,
    required this.totalItems,
    required this.totalPrice,
    required this.onOrder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: totalItems > 0 ? null : 0.0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Color(0xB3000000),
      child: totalItems > 0
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.shopping_cart, size: 24, color: Colors.white,),
              const SizedBox(width: 8),
              Text(
                "$totalItems",
                style: TextStyles.appBarText,
              ),
              const SizedBox(width: 4),
              Text(
                GetItemText.getItemText(totalItems),
                style: TextStyles.appBarText,
              ),
            ],
          ),
          const SizedBox(width: 4),
          Text(
            "${totalPrice.toStringAsFixed(0)} грн",
            style: TextStyles.appBarText,
          ),
          ElevatedButton(
            onPressed: onOrder,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              backgroundColor: Color(0x1A000000),
            ),
            child: Text(
              "Замовити >",
              style: TextStyles.cartBarText,
            ),
          ),
        ],
      )
          : const SizedBox.shrink(),
    );
  }
}
