import 'package:flutter/material.dart';

class DeliveryOptionContainer extends StatelessWidget {
  final bool isSelected;
  final BorderRadius borderRadius;
  final VoidCallback onTap;
  final String label;
  final bool excludeLeftBorder;
  final bool excludeRightBorder;

  const DeliveryOptionContainer({
    super.key,
    required this.isSelected,
    required this.borderRadius,
    required this.onTap,
    required this.label,
    this.excludeLeftBorder = false,
    this.excludeRightBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black.withAlpha(200) : Colors.white,
          border: Border(
            left: excludeLeftBorder
                ? BorderSide.none
                : BorderSide(color: Colors.black.withAlpha(200), width: 2.0),
            top: BorderSide(color: Colors.black.withAlpha(200), width: 2.0),
            right: excludeRightBorder
                ? BorderSide.none
                : BorderSide(color: Colors.black.withAlpha(200), width: 2.0),
            bottom: BorderSide(color: Colors.black.withAlpha(200), width: 2.0),
          ),
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
