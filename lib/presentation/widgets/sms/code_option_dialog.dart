import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/presentation/widgets/sms/otp_verification_dialog.dart';

class CodeOptionDialog extends StatelessWidget {
  final AuthStore authStore;

  const CodeOptionDialog({super.key, required this.authStore});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Виберіть спосіб отримання коду'),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            // authStore.sendOTP(viaWhatsApp: false);
            await _handleSendOTP(context, viaWhatsApp: false);
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

  Future<void> _handleSendOTP(BuildContext context,
      {required bool viaWhatsApp}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await authStore.sendOTP(viaWhatsApp: viaWhatsApp);

      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (_) => OTPVerificationDialog(authStore: authStore),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Помилка: ${e.toString()}')),
        );
      }
    }
  }
}
