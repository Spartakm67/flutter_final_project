import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/presentation/screens/categories_screen.dart';

class OTPVerificationDialog extends StatefulWidget {
  final AuthStore authStore;

  const OTPVerificationDialog({super.key, required this.authStore});

  @override
  State<OTPVerificationDialog> createState() => _OTPVerificationDialogState();
}

class _OTPVerificationDialogState extends State<OTPVerificationDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String otpCode = '';
  bool isVerifying = false;
  String? verificationMessage;
  Color verificationMessageColor = Colors.redAccent;
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
                verificationMessage = null;
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
          const SizedBox(height: 4),
          if (otpCode.isNotEmpty || verificationMessage != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isConfirmEnabled ? Icons.check_circle : Icons.error,
                  color: verificationMessage != null
                      ? verificationMessageColor
                      : (isConfirmEnabled ? Colors.green : Colors.redAccent),
                  size: 18,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    verificationMessage ??
                        (isConfirmEnabled
                            ? 'Натисніть кнопку "Підтвердити"'
                            : 'Код має містити 4 або 6 цифр!'),
                    style: TextStyle(
                      color: verificationMessage != null
                          ? verificationMessageColor
                          : (isConfirmEnabled
                              ? Colors.green
                              : Colors.redAccent),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
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
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: (isConfirmEnabled && !isVerifying && !widget.authStore.isLoggedIn)
                ? Colors.indigo
                : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: isVerifying
                ? null
                : () async {
                    if (isConfirmEnabled) {
                      setState(() {
                        isVerifying = true;
                      });
                      try {
                        await widget.authStore.verifyOTP(otpCode);
                        if (context.mounted && widget.authStore.isLoggedIn) {
                          setState(() {
                            verificationMessage = 'Авторизація успішна!';
                            verificationMessageColor = Colors.lightGreen;
                          });
                          Future.delayed(const Duration(seconds: 1), () {
                            if (context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CategoriesScreen(),
                                ),
                              );
                            }
                          });
                        }
                      } catch (_) {
                        if (context.mounted) {
                          setState(() {
                            verificationMessage = 'Невірний код підтвердження!';
                            verificationMessageColor = Colors.redAccent;
                          });
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            isVerifying = false;
                          });
                        }
                      }
                    } else {
                      setState(() {
                        verificationMessage = 'Код має містити 4 або 6 цифр!';
                        verificationMessageColor = Colors.redAccent;
                      });
                    }
                  },
            child: isVerifying
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Підтвердити',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ],
    );
  }
}
