import 'package:flutter/material.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

class HomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const HomeButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        text,
        style: TextStyles.homeButtonText,
      ),
    );
  }
}
