import 'package:flutter/material.dart';

class DatePickerHelper {
  Future<void> pickDate(
      BuildContext context, TextEditingController startDateController,) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      startDateController.text = pickedDate.toIso8601String().split('T')[0];
    }
  }
}
