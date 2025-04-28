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

class _OTPVerificationDialogState extends State<OTPVerificationDialog>
    with SingleTickerProviderStateMixin {
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
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: (isConfirmEnabled && !isVerifying)
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
            onPressed: (!isConfirmEnabled || isVerifying)
                ? null
                : () async {
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
