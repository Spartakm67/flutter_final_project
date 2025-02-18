// import 'package:flutter/material.dart';
// import 'api_service.dart';
// import 'incoming_order_model.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: IncomingOrderPage(),
//     );
//   }
// }
//
// class IncomingOrderPage extends StatefulWidget {
//   @override
//   _IncomingOrderPageState createState() => _IncomingOrderPageState();
// }
//
// class _IncomingOrderPageState extends State<IncomingOrderPage> {
//   final TextEditingController phoneController = TextEditingController(text: '+380680000000');
//   final TextEditingController productIdController = TextEditingController();
//   final TextEditingController countController = TextEditingController();
//
//   Future<void> createOrder() async {
//     try {
//       final incomingOrder = IncomingOrder(
//         spotId: 1,
//         phone: phoneController.text,
//         products: [
//           Product(
//             productId: int.parse(productIdController.text),
//             count: int.parse(countController.text),
//           ),
//         ],
//       );
//
//       final response = await ApiService.createIncomingOrder(incomingOrder.toJson());
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Order Created: $response')),
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $error')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Create Incoming Order')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: phoneController,
//               decoration: InputDecoration(labelText: 'Phone'),
//             ),
//             TextField(
//               controller: productIdController,
//               decoration: InputDecoration(labelText: 'Product ID'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: countController,
//               decoration: InputDecoration(labelText: 'Count'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: createOrder,
//               child: Text('Submit Order'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }