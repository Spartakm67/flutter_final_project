import 'package:flutter/material.dart';
import 'package:flutter_final_project/domain/store/home_store/home_screen_store.dart';
import 'package:flutter_final_project/presentation/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final HomeScreenStore homeScreenStore = HomeScreenStore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Final Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        home: HomeScreen(store: homeScreenStore),
    );
  }
}

