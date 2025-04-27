import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_final_project/presentation/screens/categories_screen.dart';

class OTPVerificationDialog extends StatefulWidget {
  final AuthStore authStore;

  const OTPVerificationDialog({super.key, required this.authStore});

  @override
  State<OTPVerificationDialog> createState() => _OTPVerificationDialogState();
}

class _OTPVerificationDialogState extends State<OTPVerificationDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String otpCode = '';
  bool isVerifying = false;
  bool get isConfirmEnabled => otpCode.length == 4 || otpCode.length == 6;
  static const int timerSeconds = 60;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: timerSeconds),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resendOTP() {
    widget.authStore.sendOTP();
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Введіть код підтвердження'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                otpCode = value;
              });
            },
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
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              if (_controller.isAnimating) {
                return SizedBox(
                  width: 50,
                  height: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: _controller.value,
                        strokeWidth: 5,
                      ),
                      Text(
                        '${(timerSeconds * (1 - _controller.value)).round()}с',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              } else {
                return ElevatedButton(
                  onPressed: _resendOTP,
                  child: const Text('Надіслати ще раз'),
                );
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
          onPressed: (!isConfirmEnabled || isVerifying)
              ? null
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
              isVerifying
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.indigo,
                ),
              )
                  :
              const Text('Підтвердити'),
        ),
      ],
    );
  }
}







//WORKING CODE

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
// import 'package:flutter_final_project/presentation/widgets/custom_snack_bar.dart';
// import 'package:flutter_final_project/presentation/screens/categories_screen.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// class OTPVerificationDialog extends StatefulWidget {
//   final AuthStore authStore;
//
//   const OTPVerificationDialog({super.key, required this.authStore});
//
//   @override
//   State<OTPVerificationDialog> createState() => _OTPVerificationDialogState();
// }
//
// class _OTPVerificationDialogState extends State<OTPVerificationDialog> {
//   String otpCode = '';
//   bool isVerifying = false;
//   Timer? _resendTimer;
//   int _remainingSeconds = 60;
//   bool _canResend = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _startResendTimer();
//   }
//
//   @override
//   void dispose() {
//     _resendTimer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Введіть код підтвердження'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             onChanged: (value) => otpCode = value,
//             keyboardType: TextInputType.number,
//             maxLength: 6,
//             decoration: InputDecoration(
//               hintText: 'Код OTP',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           _canResend
//               ? TextButton(
//             onPressed: () async {
//               // Коли натискаємо "Надіслати ще раз"
//               await widget.authStore.sendOTP();
//               _startResendTimer();
//             },
//             child: const Text(
//               'Надіслати ще раз',
//               style: TextStyle(color: Colors.indigo),
//             ),
//           )
//               : Text(
//             'Можна надіслати ще раз через $_remainingSeconds сек.',
//             style: const TextStyle(fontSize: 14, color: Colors.grey),
//           ),
//
//         ],
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
//           onPressed: isVerifying
//               ? null
//               : () async {
//             if (otpCode.length == 4 || otpCode.length == 6) {
//               setState(() {
//                 isVerifying = true;
//               });
//               try {
//                 await widget.authStore.verifyOTP(otpCode);
//                 if (context.mounted && widget.authStore.isLoggedIn) {
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
//               } finally {
//                 if (mounted) {
//                   setState(() {
//                     isVerifying = false;
//                   });
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
//           child:
//           isVerifying
//               ? const SizedBox(
//             width: 20,
//             height: 20,
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//               color: Colors.indigo,
//             ),
//           )
//               :
//           const Text('Підтвердити'),
//         ),
//       ],
//     );
//   }
//
//   void _startResendTimer() {
//     _resendTimer?.cancel(); // обов'язково зупиняємо попередній таймер
//     setState(() {
//       _remainingSeconds = 60;
//       _canResend = false;
//     });
//     _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingSeconds == 0) {
//         timer.cancel();
//         setState(() {
//           _canResend = true;
//         });
//       } else {
//         setState(() {
//           _remainingSeconds--;
//         });
//       }
//     });
//   }
// }


//PreOLD CODE

// class OTPVerificationDialog extends StatefulWidget {
//   final AuthStore authStore;
//
//   const OTPVerificationDialog({super.key, required this.authStore});
//
//   @override
//   State<OTPVerificationDialog> createState() => _OTPVerificationDialogState();
// }
//
// class _OTPVerificationDialogState extends State<OTPVerificationDialog> {
//   String otpCode = '';
//   bool isVerifying = false; // коли натиснуто кнопку Підтвердити
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Введіть код підтвердження'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             onChanged: (value) => otpCode = value,
//             keyboardType: TextInputType.number,
//             maxLength: 6,
//             decoration: InputDecoration(
//               hintText: 'Код OTP',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Observer(
//             builder: (_) {
//               if (isVerifying) {
//                 return Column(
//                   children: const [
//                     CircularProgressIndicator(),
//                     SizedBox(height: 8),
//                     Text(
//                       'Перевіряємо код...',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 );
//               } else if (widget.authStore.isWaitingForSms) {
//                 return Column(
//                   children: const [
//                     CircularProgressIndicator(),
//                     SizedBox(height: 8),
//                     Text(
//                       'Очікуємо SMS з кодом...',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 );
//               } else {
//                 return const SizedBox.shrink();
//               }
//             },
//           ),
//         ],
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
//           onPressed: isVerifying
//               ? null
//               : () async {
//             if (otpCode.length == 4 || otpCode.length == 6) {
//               setState(() {
//                 isVerifying = true;
//               });
//               try {
//                 await widget.authStore.verifyOTP(otpCode);
//                 if (context.mounted && widget.authStore.isLoggedIn) {
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
//               } finally {
//                 if (mounted) {
//                   setState(() {
//                     isVerifying = false;
//                   });
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
//           child:
//           // isVerifying
//           //     ? const SizedBox(
//           //   width: 20,
//           //   height: 20,
//           //   child: CircularProgressIndicator(
//           //     strokeWidth: 2,
//           //     color: Colors.indigo,
//           //   ),
//           // )
//           //     :
//           const Text('Підтвердити'),
//         ),
//       ],
//     );
//   }
// }



//OLD CODE

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