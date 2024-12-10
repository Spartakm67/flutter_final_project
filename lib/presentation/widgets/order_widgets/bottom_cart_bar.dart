import 'package:flutter/material.dart';

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

  String _getItemText(int count) {
    if (count == 1) return "товар";
    if (count >= 2 && count <= 4) return "товари";
    return "товарів";
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: totalItems > 0 ? null : 0.0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.black.withOpacity(0.7),
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
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(width: 4),
              Text(
                _getItemText(totalItems),
                style: const TextStyle(fontSize: 22, color: Colors.white),
              ),
            ],
          ),
          Text(
            "${totalPrice.toStringAsFixed(0)} грн",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          ElevatedButton(
            onPressed: onOrder,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              backgroundColor: Colors.black.withOpacity(0.1),
            ),
            child: const Text(
              "Замовити >",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      )
          : const SizedBox.shrink(),
    );
  }
}
