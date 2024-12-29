import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/home_store/home_screen_store.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/presentation/widgets/home_button.dart';
import 'package:flutter_final_project/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/cart_preview_container.dart';
import 'package:flutter_final_project/presentation/widgets/custom_dialog.dart';
import 'package:flutter_final_project/presentation/widgets/custom_burger_button.dart';
import 'package:flutter_final_project/presentation/widgets/sms/code_option_dialog.dart';
import 'package:flutter_final_project/presentation/widgets/contacts/contacts_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:flutter_final_project/presentation/screens/categories_screen.dart';
import 'package:flutter_final_project/presentation/screens/auth/auth_email_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final HomeScreenStore store;

  const HomeScreen({super.key, required this.store});

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
    final authStore = Provider.of<AuthStore>(context);
    final cartStore = Provider.of<CartStore>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Observer(
        builder: (_) => Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/pancake_blackout.jpg',
                fit: BoxFit.cover,
              ),
            ),
            AnimatedBuilder(
              animation: _alignAnimation,
              builder: (context, child) {
                return Align(
                  alignment: _alignAnimation.value,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
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
                            const Text(
                              'Майстерня Млинців \n Ласкаво просимо!',
                              textAlign: TextAlign.center,
                              style: TextStyles.greetingsText,
                            ),
                            const SizedBox(height: 8),
                            const Text(
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
                                        color: Colors.deepPurple,
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
                                        const Text(
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
                                      autofocus: true,
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
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (authStore.phoneNumber?.isNotEmpty ??
                                          false) {
                                        if (!authStore.isPhoneNumberValid(
                                          authStore.phoneNumber!,
                                        )) {
                                          CustomSnackBar.show(
                                            context: context,
                                            message:
                                                'Номер телефону має містити 9 цифр!',
                                            backgroundColor: Colors.redAccent,
                                            position: SnackBarPosition.top,
                                          );
                                          return;
                                        }
                                        showDialog(
                                          context: context,
                                          builder: (_) => CodeOptionDialog(
                                            authStore: authStore,
                                          ),
                                        );
                                      } else {
                                        CustomSnackBar.show(
                                          context: context,
                                          message:
                                              'Будь ласка, введіть номер телефону!',
                                          backgroundColor: Colors.redAccent,
                                          position: SnackBarPosition.top,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'SMS',
                                      style: TextStyles.authText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'або авторизуйтеся за допомогою:',
                              textAlign: TextAlign.center,
                              style: TextStyles.authWelcomeText,
                            ),
                            const SizedBox(height: 8),
                            ...[
                              {
                                'icon': FontAwesomeIcons.google,
                                'imagePath': 'assets/images/google_logo.webp',
                                'label': 'Google',
                                'iconStyle': TextStyles.hintText,
                                'onPressed': () async {
                                  final result =
                                      await authStore.signInWithGoogle();
                                  if (result) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CategoriesScreen(),
                                        ),
                                      );
                                    });
                                  } else if (authStore.errorMessage != null) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text(authStore.errorMessage!),
                                        ),
                                      );
                                    });
                                  }
                                },
                              },
                              {
                                'icon': FontAwesomeIcons.apple,
                                'label': 'Apple',
                                'iconStyle':
                                    TextStyles.authIconStyle(Colors.black),
                                'onPressed': () {
                                  print('Авторизація через Apple');
                                },
                              },
                              {
                                'icon': FontAwesomeIcons.facebook,
                                'label': 'Facebook',
                                'iconStyle':
                                    TextStyles.authIconStyle(Colors.blue),
                                'onPressed': () {
                                  print('Авторизація через Facebook');
                                },
                              },
                              {
                                'icon': Icons.email,
                                'label': 'Електронна пошта',
                                'iconStyle':
                                    TextStyles.authIconStyle(Colors.orange),
                                'onPressed': () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const AuthEmailScreen();
                                      },
                                    ),
                                  );
                                },
                              },
                            ].map(
                              (auth) {
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 4,
                                  child: InkWell(
                                    onTap: auth['onPressed'] as VoidCallback,
                                    borderRadius: BorderRadius.circular(16),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              auth['imagePath'] != null
                                                  ? Image.asset(
                                                      auth['imagePath']
                                                          as String,
                                                      width: 24,
                                                      height: 24,
                                                    )
                                                  : Icon(
                                                      auth['icon'] as IconData,
                                                      size: (auth['iconStyle']
                                                                  as TextStyle)
                                                              .fontSize ??
                                                          24,
                                                      color: (auth['iconStyle']
                                                              as TextStyle)
                                                          .color,
                                                    ),
                                            ],
                                          ),
                                          Center(
                                            child: Text(
                                              auth['label'] as String,
                                              textAlign: TextAlign.center,
                                              style: TextStyles.authText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
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
                    borderColor: Colors.grey,
                    borderRadius: 12.0,
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => const ContactsWidget(),
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
}
