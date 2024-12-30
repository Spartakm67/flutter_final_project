import 'package:flutter/material.dart';

class CustomBurgerButton extends StatelessWidget {
  final Color backgroundColor;
  final Color lineColor;
  final Color borderColor;
  final double borderRadius;
  final VoidCallback onTap;
  final double lineSpacing;

  const CustomBurgerButton({
    super.key,
    this.backgroundColor = Colors.white,
    this.lineColor = Colors.black,
    this.borderColor = Colors.grey,
    this.borderRadius = 12.0,
    this.lineSpacing = 4.0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46.0,
        height: 44.0,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLine(),
            SizedBox(height: lineSpacing),
            _buildLine(),
            SizedBox(height: lineSpacing),
            _buildLine(),
          ],
        ),
      ),
    );
  }

  Widget _buildLine() {
    return Container(
      width: 24.0,
      height: 2.5,
      color: lineColor,
    );
  }
}
