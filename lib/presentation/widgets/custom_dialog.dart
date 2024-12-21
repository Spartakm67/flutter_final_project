import 'package:flutter/material.dart';

class CustomDialog {
  static void show({
    required BuildContext context,
    required WidgetBuilder builder,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 300),
    bool barrierDismissible = true,
    String barrierLabel = 'Закрити', // Додано barrierLabel
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      transitionDuration: transitionDuration,
      pageBuilder: (context, _, __) => builder(context),
    );
  }
}

