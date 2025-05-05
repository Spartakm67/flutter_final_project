import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/categories_store/categories_store.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/domain/store/firebase_store/firebase_store.dart';
import 'package:flutter_final_project/data/models/hive/product_counter_hive.dart';
import 'package:flutter_final_project/data/models/hive/order_model_hive.dart';
import 'package:flutter_final_project/data/models/hive/time_of_day_adapter.dart';
import 'package:flutter_final_project/presentation/screens/home_screen.dart';
import 'package:flutter_final_project/presentation/screens/categories_screen.dart';
import 'package:flutter_final_project/presentation/screens/auth/loading_app.dart';
import 'package:flutter_final_project/presentation/screens/auth/error_app.dart';
import 'package:flutter_final_project/presentation/styles/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

double screenWidth = 0;
double screenHeight = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final mediaQuery = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.first,
  );
  screenWidth = mediaQuery.size.width;
  screenHeight = mediaQuery.size.height;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const LoadingApp());

  try {
    await dotenv.load(fileName: '.env');

    final firebaseStore = FirebaseStore();
    await firebaseStore.initialize();

    await Hive.initFlutter();
    Hive.registerAdapter(ProductCounterHiveAdapter());
    Hive.registerAdapter(OrderModelHiveAdapter());
    Hive.registerAdapter(TimeOfDayAdapter());

    await Hive.openBox('authBox'); // Відкриваємо Hive box для зберігання токена

    final productStore = ProductStore();
    final orderStore = OrderStore();
    final cartStore = CartStore(productStore, orderStore);
    final authStore = AuthStore();
    final categoriesStore = CategoriesStore();

    await cartStore.initHive();
    await orderStore.initHive();

    // ✅ Використовуємо новий метод у AuthStore
    await authStore.restoreSessionFromHive();
    print('Saved UID: ${Hive.box('authBox').get('uid')}');


    runApp(
      MultiProvider(
        providers: [
          Provider<ProductStore>.value(value: productStore),
          Provider<CartStore>.value(value: cartStore),
          Provider<AuthStore>.value(value: authStore),
          Provider<OrderStore>.value(value: orderStore),
          Provider<CategoriesStore>.value(value: categoriesStore),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('Initialization error: $e\n$stackTrace');
    runApp(const ErrorApp(message: 'Failed to initialize app'));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    return Observer(
      builder: (_) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Final Project',
          theme: appTheme,
          home: authStore.isLoggedIn
              ? const CategoriesScreen()
              : const HomeScreen(),
        );
      },
    );
  }
}




