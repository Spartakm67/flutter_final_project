import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_final_project/presentation/screens/categories_screen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// class OTPVerificationDialog extends StatelessWidget {
//   final AuthStore authStore;
//
//   const OTPVerificationDialog({super.key, required this.authStore});
//
//   @override
//   Widget build(BuildContext context) {
//     String otpCode = '';
//
//     return AlertDialog(
//       title: const Text('Введіть код підтвердження'),
//       content: TextField(
//         onChanged: (value) => otpCode = value,
//         keyboardType: TextInputType.number,
//         maxLength: 6,
//         decoration: InputDecoration(
//           hintText: 'Код OTP',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           style: TextButton.styleFrom(
//             backgroundColor: Colors.white60,
//             foregroundColor: Colors.indigo,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//           ),
//           onPressed: () async {
//             if (otpCode.length == 4 || otpCode.length == 6) {
//               try {
//                 await authStore.verifyOTP(otpCode);
//                 if (context.mounted && authStore.isLoggedIn) {
//                   CustomSnackBar.show(
//                     context: context,
//                     message: 'Авторизація успішна!',
//                     backgroundColor: Colors.lightGreen,
//                     position: SnackBarPosition.top,
//                   );
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const CategoriesScreen(),
//                     ),
//                   );
//                 }
//               } catch (_) {
//                 if (context.mounted) {
//                   CustomSnackBar.show(
//                     context: context,
//                     message: 'Невірний код підтвердження!',
//                     backgroundColor: Colors.redAccent,
//                     position: SnackBarPosition.top,
//                   );
//                 }
//               }
//             } else {
//               if (context.mounted) {
//                 CustomSnackBar.show(
//                   context: context,
//                   message: 'Код повинен мати 4 або 6 цифр!',
//                   backgroundColor: Colors.redAccent,
//                   position: SnackBarPosition.top,
//                 );
//               }
//             }
//           },
//           child: const Text('Підтвердити'),
//         ),
//       ],
//     );
//   }
// }

class OTPVerificationDialog extends StatefulWidget {
  final AuthStore authStore;

  const OTPVerificationDialog({super.key, required this.authStore});

  @override
  State<OTPVerificationDialog> createState() => _OTPVerificationDialogState();
}

class _OTPVerificationDialogState extends State<OTPVerificationDialog> {
  String otpCode = '';
  bool isVerifying = false; // коли натиснуто кнопку Підтвердити

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Введіть код підтвердження'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) => otpCode = value,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: InputDecoration(
              hintText: 'Код OTP',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Observer(
          //   builder: (_) {
          //     if (widget.authStore.isWaitingForSms) {
          //       return Column(
          //         children: const [
          //           CircularProgressIndicator(),
          //           SizedBox(height: 8),
          //           Text(
          //             'Очікуємо SMS з кодом...',
          //             style: TextStyle(fontSize: 14),
          //           ),
          //         ],
          //       );
          //     }
          //     return const SizedBox.shrink(); // нічого не показувати, якщо код уже надіслано
          //   },
          // ),
          Observer(
            builder: (_) {
              if (isVerifying) {
                return Column(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text(
                      'Перевіряємо код...',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                );
              } else if (widget.authStore.isWaitingForSms) {
                return Column(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text(
                      'Очікуємо SMS з кодом...',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),

        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white60,
            foregroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          onPressed: isVerifying
              ? null // блокуємо кнопку під час перевірки
              : () async {
            if (otpCode.length == 4 || otpCode.length == 6) {
              setState(() {
                isVerifying = true;
              });
              try {
                await widget.authStore.verifyOTP(otpCode);
                if (context.mounted && widget.authStore.isLoggedIn) {
                  CustomSnackBar.show(
                    context: context,
                    message: 'Авторизація успішна!',
                    backgroundColor: Colors.lightGreen,
                    position: SnackBarPosition.top,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesScreen(),
                    ),
                  );
                }
              } catch (_) {
                if (context.mounted) {
                  CustomSnackBar.show(
                    context: context,
                    message: 'Невірний код підтвердження!',
                    backgroundColor: Colors.redAccent,
                    position: SnackBarPosition.top,
                  );
                }
              } finally {
                if (mounted) {
                  setState(() {
                    isVerifying = false;
                  });
                }
              }
            } else {
              if (context.mounted) {
                CustomSnackBar.show(
                  context: context,
                  message: 'Код повинен мати 4 або 6 цифр!',
                  backgroundColor: Colors.redAccent,
                  position: SnackBarPosition.top,
                );
              }
            }
          },
          child:
          // isVerifying
          //     ? const SizedBox(
          //   width: 20,
          //   height: 20,
          //   child: CircularProgressIndicator(
          //     strokeWidth: 2,
          //     color: Colors.indigo,
          //   ),
          // )
          //     :
          const Text('Підтвердити'),
        ),
      ],
    );
  }
}