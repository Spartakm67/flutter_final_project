import 'package:flutter/material.dart';
import 'package:flutter_final_project/services/poster_api/create_incoming_order.dart';
import 'package:flutter_final_project/data/models/poster/incoming_order.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IncomingOrderPage(),
    );
  }
}

class IncomingOrderPage extends StatefulWidget {
  const IncomingOrderPage({super.key});

  @override
  IncomingOrderPageState createState() => IncomingOrderPageState();
}

class IncomingOrderPageState extends State<IncomingOrderPage> {
  final TextEditingController phoneController = TextEditingController(text: '+380680000000');
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  Future<void> createOrder() async {
    try {
      final incomingOrder = IncomingOrder(
        spotId: 1,
        phone: phoneController.text,
        products: [
          Product(
            productId: int.parse(productIdController.text),
            count: int.parse(countController.text),
          ),
        ],
      );
      final messenger = ScaffoldMessenger.of(context);
      final response = await ApiService.createIncomingOrder(incomingOrder.toJson());
      messenger.showSnackBar(
        SnackBar(content: Text('Order Created: $response')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Incoming Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: productIdController,
              decoration: const InputDecoration(labelText: 'Product ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: countController,
              decoration: const InputDecoration(labelText: 'Count'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createOrder,
              child: const Text('Submit Order'),
            ),
          ],
        ),
      ),
    );
  }
}