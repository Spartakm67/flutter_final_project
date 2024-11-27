import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/home_store/home_screen_store.dart';

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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _alignAnimation = Tween<Alignment>(
      begin: const Alignment(0.0, 5.0),
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = widget.store;

    return Scaffold(
      body: Observer(
        builder: (_) => Stack(
          children: [
            FadeTransition(
              opacity: _animationController,
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Colors.orange, Colors.pink, Colors.purple],
                    ),
                  ),
                ),
              ),
            ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Ласкаво просимо',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.flag, size: 24),
                                    SizedBox(width: 8),
                                    Text('+380'),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  onChanged: store.setPhoneNumber,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'Мобільний номер',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...[
                            {
                              'icon': Icons.g_mobiledata,
                              'label': 'Google',
                              'onPressed': () {
                                print('Авторизація через Google');
                              },
                            },
                            {
                              'icon': Icons.apple,
                              'label': 'Apple',
                              'onPressed': () {
                                print('Авторизація через Apple');
                              },
                            },
                            {
                              'icon': Icons.facebook,
                              'label': 'Facebook',
                              'onPressed': () {
                                print('Авторизація через Facebook');
                              },
                            },
                            {
                              'icon': Icons.email,
                              'label': 'Електронна пошта',
                              'onPressed': () {
                                print('Авторизація через електронну пошту');
                              },
                            },
                          ].map(
                            (auth) {
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: InkWell(
                                  onTap: auth['onPressed'] as VoidCallback,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center, // Центруємо всі елементи
                                      children: [
                                        const Spacer(), // Залишаємо простір перед іконкою
                                        Icon(auth['icon'] as IconData,
                                            size: 28,),
                                        const SizedBox(
                                            width:
                                                16,), // Відступ між іконкою та текстом
                                        Expanded(
                                          child: Text(
                                            auth['label'] as String,
                                            textAlign: TextAlign
                                                .center, // Центруємо текст по Card
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Spacer(), // Залишаємо простір після тексту
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
