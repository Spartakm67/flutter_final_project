import 'package:flutter/material.dart';

class BottomCartBar extends StatelessWidget {
  final int totalItems; // Загальна кількість товарів
  final double totalPrice; // Загальна сума
  final VoidCallback onOrder; // Callback для кнопки "замовити"

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
      height: totalItems > 0 ? null : 0.0, // Висота віджета залежить від наявності товарів
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: totalItems > 0
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.shopping_cart, size: 24),
              const SizedBox(width: 8),
              Text(
                "$totalItems",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              Text(
                _getItemText(totalItems),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Text(
            "${totalPrice.toStringAsFixed(2)} грн",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: onOrder,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text(
              "Замовити >",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      )
          : const SizedBox.shrink(), // Пустий віджет, якщо товарів немає
    );
  }
}
