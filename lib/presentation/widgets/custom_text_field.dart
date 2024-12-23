import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText = 'Введіть текст',
    this.hintText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.onChanged,
    this.keyboardType,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon, color: Colors.grey),
          onPressed: onSuffixIconPressed,
        )
            : null,
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      onChanged: onChanged,
    );
  }
}
