import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';

class CodeOptionDialog extends StatelessWidget {
  final AuthStore authStore;

  const CodeOptionDialog({super.key, required this.authStore});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Виберіть спосіб отримання коду'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            authStore.sendOTP(viaWhatsApp: false);
          },
          child: const Text('SMS'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            authStore.sendOTP(viaWhatsApp: true);
          },
          child: const Text('WhatsApp'),
        ),
      ],
    );
  }
}
