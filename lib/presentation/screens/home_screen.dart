import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/presentation/widgets/home_button.dart';
import 'package:flutter_final_project/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/cart_preview_container.dart';
import 'package:flutter_final_project/presentation/widgets/custom_dialog.dart';
import 'package:flutter_final_project/presentation/widgets/custom_burger_button.dart';
import 'package:flutter_final_project/presentation/widgets/contacts/burger_widget.dart';
import 'package:flutter_final_project/presentation/widgets/sms/otp_verification_dialog.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:flutter_final_project/presentation/screens/categories_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_final_project/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _alignAnimation;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _alignAnimation = Tween<Alignment>(
      begin: const Alignment(0.0, 7.0),
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _animationController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderStore = Provider.of<OrderStore>(context);
    final authStore = Provider.of<AuthStore>(context);
    final cartStore = Provider.of<CartStore>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Observer(
        builder: (_) => Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/pancake_blackout.webp',
                fit: BoxFit.cover,
              ),
            ),
            AnimatedBuilder(
              animation: _alignAnimation,
              builder: (context, child) {
                return Align(
                  alignment: _alignAnimation.value,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.8),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      reverse: false,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: screenHeight * 0.015),
                            Text(
                              'Майстерня Млинців \n Ласкаво просимо!',
                              textAlign: TextAlign.center,
                              style: TextStyles.greetingsText,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Для оформлення замовлення введіть:',
                              textAlign: TextAlign.center,
                              style: TextStyles.authWelcomeText,
                            ),
                            const SizedBox(height: 16),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black87,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'icons/flags/png100px/ua.png',
                                          package: 'country_icons',
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '+380',
                                          style: TextStyles.authText,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: phoneController,
                                      onChanged: authStore.setPhoneNumber,
                                      keyboardType: TextInputType.phone,
                                      style: TextStyles.authText,
                                      // autofocus: true,
                                      decoration: InputDecoration(
                                        hintText: 'Мобільний номер',
                                        hintStyle: TextStyles.hintText,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            HomeButton(
                              onPressed: () async {
                                if (authStore.phoneNumber == null ||
                                    authStore.phoneNumber!.trim().isEmpty) {
                                  CustomSnackBar.show(
                                    context: context,
                                    message:
                                        'Будь ласка, введіть номер телефону!',
                                    backgroundColor: Colors.redAccent,
                                    position: SnackBarPosition.top,
                                  );
                                  return;
                                }

                                if (!authStore.isPhoneNumberValid(
                                    authStore.phoneNumber!,)) {
                                  CustomSnackBar.show(
                                    context: context,
                                    message:
                                        'Номер телефону має містити 9 цифр!',
                                    backgroundColor: Colors.redAccent,
                                    position: SnackBarPosition.top,
                                  );
                                  return;
                                }

                                final formattedPhoneNumber =
                                    '+380${authStore.phoneNumber!.replaceFirst(RegExp(r'^\+?380?'), '')}';
                                orderStore.updateOrder(
                                    phone: formattedPhoneNumber,);

                                await _handleSendOTP(context,
                                    authStore: authStore,);

                                if (context.mounted) {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (_) => OTPVerificationDialog(
                                        authStore: authStore,),
                                  );
                                }
                              },
                              text: 'Надіслати код підтвердження',
                              backgroundColor: Colors.deepOrangeAccent,
                              textColor: Colors.white,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Робочі години: 9:00 - 20:00\n Без вихідних\n'
                                  'Працюємо в м.Київ\n'
                                  'Доставка замовлень\n'
                                  'на лівому березі',
                              textAlign: TextAlign.center,
                              style: TextStyles.authWelcomeText,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            const SizedBox(height: 16),
                            FittedBox(
                              child: HomeButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const CategoriesScreen();
                                      },
                                    ),
                                  );
                                },
                                text: 'Пропустити та перейти до меню',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              right: 8,
              left: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBurgerButton(
                    backgroundColor: Colors.white,
                    lineColor: Colors.black,
                    borderRadius: 12.0,
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => const BurgerWidget(),
                    ),
                  ),
                  Row(
                    children: [
                      if (cartStore.totalItems > 0)
                        GestureDetector(
                          onTap: () {
                            CustomDialog.show(
                              context: context,
                              builder: (_) => const CartPreviewContainer(),
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                size: 30,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                cartStore.totalItems.toString(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(width: 20),
                      HomeButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const CategoriesScreen();
                              },
                            ),
                          );
                        },
                        text: 'Меню',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSendOTP(BuildContext context,
      {required AuthStore authStore,}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await authStore.sendOTP();
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
