import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class AppTheme {
//   static final lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.blue,
//     scaffoldBackgroundColor: Colors.white,
//     textTheme: GoogleFonts.poppinsTextTheme(),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blue,
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//   );
//
//   static final darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: Colors.teal,
//     scaffoldBackgroundColor: Colors.black,
//     textTheme: GoogleFonts.poppinsTextTheme(
//       ThemeData.dark().textTheme,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.teal,
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//   );
// }


final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF333333),
    secondary: Color(0xFFB0BEC5),
    surface: Color(0xFFF5F5F5),
    onPrimary: Colors.white,
    onSurface: Colors.black87,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),
    elevation: 0,
    scrolledUnderElevation: 0,
    foregroundColor: Color(0xFF333333),
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    shape: Border(
      bottom: BorderSide(
        color: Color(0xFFE0E0E0),
        width: 1,
      ),
    ),
  ),
);


// theme: ThemeData(
//   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade50),
//   useMaterial3: true,
// ),

// theme: ThemeData(
//   colorScheme: const ColorScheme.light(
//     primary: Colors.black,
//     secondary: Colors.grey,
//     surface: Colors.white,
//     onPrimary: Colors.white,
//     onSurface: Colors.black,
//   ),
//   useMaterial3: true,
// ),