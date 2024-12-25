import 'package:flutter/material.dart';

class DeliveryOptionContainer extends StatelessWidget {
  final bool isSelected;
  final BorderRadius borderRadius;
  final VoidCallback onTap;
  final String label;

  const DeliveryOptionContainer({
    super.key,
    required this.isSelected,
    required this.borderRadius,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black.withAlpha(200) : Colors.white,
          border: Border.all(
            color: Colors.black.withAlpha(200),
            width: 2.0,
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
