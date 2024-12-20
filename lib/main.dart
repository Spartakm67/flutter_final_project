import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/home_store/home_screen_store.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/domain/store/firebase_store/firebase_store.dart';
import 'package:flutter_final_project/data/models/hive/product_counter_hive.dart';
import 'package:flutter_final_project/presentation/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final firebaseStore = FirebaseStore();
  await firebaseStore.initialize();

  await Hive.initFlutter();
  Hive.registerAdapter(ProductCounterHiveAdapter());
  final productStore = ProductStore();
  final cartStore = CartStore(productStore);
  final authStore = AuthStore();
  await cartStore.initHive();

  runApp(
    MultiProvider(
      providers: [
        Provider<ProductStore>.value(
          value: productStore,
        ),
        Provider<CartStore>.value(
          value: cartStore,
        ),
        Provider<AuthStore>.value(
          value: authStore,
        ),
        Provider<HomeScreenStore>(
          create: (_) => HomeScreenStore(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Final Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(
        store: Provider.of<HomeScreenStore>(context, listen: false),
      ),
    );
  }
}


