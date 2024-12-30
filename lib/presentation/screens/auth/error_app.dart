import 'package:flutter/material.dart';

class ErrorApp extends StatelessWidget {
  final String message;
  const ErrorApp({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

//
// class ErrorScreen extends StatelessWidget {
//   final String errorMessage;
//
//   const ErrorScreen({super.key, required this.errorMessage});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error, size: 50, color: Colors.red),
//             const SizedBox(height: 20),
//             const Text(
//               'Initialization Failed',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
//             ),
//             const SizedBox(height: 10),
//             Text(errorMessage, textAlign: TextAlign.center),
//           ],
//         ),
//       ),
//     );
//   }
// }