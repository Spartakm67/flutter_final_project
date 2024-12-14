import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/presentation/widgets/custom_snack_bar.dart';

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
          onPressed: () async {
            if (otpCode.length == 4) {
              try {
                await authStore.verifyOTP(otpCode);
                if (context.mounted && authStore.isLoggedIn) {
                  Navigator.pop(context);
                  CustomSnackBar.show(
                    context: context,
                    message: 'Авторизація успішна!',
                    backgroundColor: Colors.lightGreen,
                    position: SnackBarPosition.top,
                  );
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Авторизація успішна!')),
                  // );
                }
              } catch (_) {
                if (context.mounted) {
                  CustomSnackBar.show(
                    context: context,
                    message: 'Невірний код підтвердження!',
                    backgroundColor: Colors.redAccent,
                    position: SnackBarPosition.top,
                  );
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Невірний код підтвердження!')),
                  // );
                }
              }
            } else {
              if (context.mounted) {
                CustomSnackBar.show(
                  context: context,
                  message: 'Код повинен мати 4 цифри!',
                  backgroundColor: Colors.redAccent,
                  position: SnackBarPosition.top,
                );
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Код має бути 4 цифри!')),
                // );
              }
            }
          },
          child: const Text('Підтвердити'),
        ),
      ],
    );
  }
}

