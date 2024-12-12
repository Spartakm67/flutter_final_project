import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';

class OTPVerificationDialog extends StatelessWidget {
  final AuthStore authStore;

  const OTPVerificationDialog({super.key, required this.authStore});

  @override
  Widget build(BuildContext context) {
    String otpCode = '';

    return AlertDialog(
      title: const Text('Введіть код підтвердження'),
      content: TextField(
        onChanged: (value) => otpCode = value,
        keyboardType: TextInputType.number,
        maxLength: 4,
        decoration: InputDecoration(
          hintText: 'Код OTP',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (otpCode.length == 4) {
              authStore.verifyOTP(otpCode).then((_) {
                if (authStore.isLoggedIn) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Авторизація успішна!')),
                  );
                }
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Код має бути 4 цифри!')),
              );
            }
          },
          child: const Text('Підтвердити'),
        ),
      ],
    );
  }
}
