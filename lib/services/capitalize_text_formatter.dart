import 'package:flutter/services.dart';

class CapitalizeTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;

    final formattedText = text.isNotEmpty
        ? text[0].toUpperCase() + text.substring(1).toLowerCase()
        : '';

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

