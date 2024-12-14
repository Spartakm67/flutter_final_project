import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.redAccent,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
    Duration duration = const Duration(seconds: 3),
    SnackBarPosition position = SnackBarPosition.bottom,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position == SnackBarPosition.top ? margin.vertical : null,
        bottom: position == SnackBarPosition.bottom ? margin.vertical : null,
        left: margin.horizontal,
        right: margin.horizontal,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}

enum SnackBarPosition { top, bottom, center }
