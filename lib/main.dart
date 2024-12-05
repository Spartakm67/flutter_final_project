import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/home_store/home_screen_store.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/presentation/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final productStore = ProductStore();
  final cartStore = CartStore(productStore);
  await cartStore.initHive();

  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        Provider<ProductStore>.value(
          value: productStore,
        ),
        Provider<CartStore>.value(
          value: cartStore,
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


