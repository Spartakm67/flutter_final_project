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
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: totalItems > 0
          ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        color: const Color(0xB3000000),
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return _ResponsiveCartRow(
              onOrder: onOrder,
              totalItems: totalItems,
              totalPrice: totalPrice,
              maxWidth: constraints.maxWidth,
            );
          },
        ),
      )
          : const SizedBox.shrink(),
    );
  }
}

class _ResponsiveCartRow extends StatelessWidget {
  final int totalItems;
  final double totalPrice;
  final VoidCallback onOrder;
  final double maxWidth;

  const _ResponsiveCartRow({
    required this.totalItems,
    required this.totalPrice,
    required this.onOrder,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double buttonMinWidth = 180; // Мінімальна ширина кнопки
        final double padding = 32; // Запас для відступів

        // Визначаємо фактичні розміри текстових елементів
        final double textWidth = _getTextWidth(
          "$totalItems ${GetItemText.getItemText(totalItems)}",
          TextStyles.cartBarBtnText,
        );

        final double priceWidth = _getTextWidth(
          "${totalPrice.toStringAsFixed(0)} грн",
          TextStyles.cartBarBtnText,
        );

        // Загальна ширина всіх елементів
        final double totalContentWidth = textWidth + priceWidth + buttonMinWidth + padding;

        // Використовуємо Column, якщо не вміщається в один рядок
        final bool useColumn = totalContentWidth > maxWidth;

        return useColumn
            ? Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: _buildCartInfo()), // Гнучка адаптація
                const SizedBox(width: 8),
                _buildPriceText(),
              ],
            ),
            const SizedBox(height: 8),
            _buildOrderButton(),
          ],
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildCartInfo()),
            const SizedBox(width: 8),
            _buildPriceText(),
            const SizedBox(width: 8),
            Flexible(child: _buildOrderButton()), // Запобігає переповненню
          ],
        );
      },
    );
  }

  Widget _buildCartInfo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 8),
        const Icon(Icons.shopping_cart, size: 24, color: Colors.white),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            "$totalItems ${GetItemText.getItemText(totalItems)}",
            style: TextStyles.cartBarBtnText,
            overflow: TextOverflow.ellipsis, // Запобігання переповненню
          ),
        ),
      ],
    );
  }

  Widget _buildPriceText() {
    return Text(
      "${totalPrice.toStringAsFixed(0)} грн",
      style: TextStyles.cartBarBtnText,
    );
  }

  Widget _buildOrderButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 110), // Мінімальна ширина кнопки
      child: ElevatedButton(
        onPressed: onOrder,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          backgroundColor: const Color(0x1A000000),
        ),
        child: Text(
          "Замовити >",
          style: TextStyles.cartBarBtnText,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  // Метод для підрахунку ширини тексту
  double _getTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }
}
