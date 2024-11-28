import 'package:flutter/material.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyles.buttonText,
        ),
      ),
    );
  }
}
