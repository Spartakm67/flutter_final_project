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

// class ErrorApp extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;
//
//   const ErrorApp({super.key, required this.message, required this.onRetry});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/error.jpg',
//                   width: 150,
//                   height: 150,
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   message,
//                   style: const TextStyle(fontSize: 18, color: Colors.red),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: onRetry,
//                   child: const Text('Спробувати знову'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// Widget build(BuildContext context) {
//   return FutureBuilder(
//     future: widget.store.loadData(), // Ваш метод отримання даних
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return ErrorApp(
//           message: 'Помилка завантаження даних',
//           onRetry: () {
//             setState(() {}); // Перезавантаження екрану
//           },
//         );
//       } else {
//         return YourHomeScreenContent(); // Основний контент
//       }
//     },
//   );
// }
