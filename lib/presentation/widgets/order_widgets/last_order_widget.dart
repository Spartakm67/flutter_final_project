import 'package:flutter/material.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:hive/hive.dart';

class LastOrderWidget extends StatefulWidget {
  const LastOrderWidget({super.key});

  @override
  LastOrderWidgetState createState() => LastOrderWidgetState();
}

class LastOrderWidgetState extends State<LastOrderWidget> {
  Map<String, int>? lastOrderItems;
  String? lastComment;
  double? totalPrice, deliveryPrice, finalPrice;

  @override
  void initState() {
    super.initState();
    _loadLastOrder();
  }

  Future<void> _loadLastOrder() async {
    final lastOrderBox = await Hive.openBox<Map>('last_order');
    final lastOrder = lastOrderBox.get('order');

    if (lastOrder != null) {
      setState(() {
        lastOrderItems = Map<String, int>.from(lastOrder['items']);
        lastComment = lastOrder['comment'];
        totalPrice = lastOrder['totalPrice'];
        deliveryPrice = lastOrder['deliveryPrice'];
        finalPrice = lastOrder['finalPrice'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Попереднє замовлення', style: TextStyles.cartBottomText,)),
      body: lastOrderItems == null
          ? Center(child: Text('Немає попереднього замовлення', style: TextStyles.greetingsText, ))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Загальна сума: ${totalPrice?.toStringAsFixed(2)} грн',
                style: Theme.of(context).textTheme.titleMedium),
            Text('Доставка: ${deliveryPrice?.toStringAsFixed(2)} грн',
                style: Theme.of(context).textTheme.titleMedium),
            Text('До сплати: ${finalPrice?.toStringAsFixed(2)} грн',
                style: Theme.of(context).textTheme.titleMedium),
            if (lastComment != null && lastComment!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Коментар: $lastComment',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: lastOrderItems!.length,
                itemBuilder: (context, index) {
                  String productId = lastOrderItems!.keys.elementAt(index);
                  int quantity = lastOrderItems![productId]!;
                  return ListTile(
                    title: Text('Продукт: $productId'),
                    subtitle: Text('Кількість: $quantity'),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Логіка повторного замовлення
                  Navigator.pop(context);
                },
                child: const Text('Повторити замовлення'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ElevatedButton(
// onPressed: () {
// showDialog(
// context: context,
// builder: (context) => LastOrderWidget(
// onRepeatOrder: (items, comment) {
// // Логіка повторного замовлення
// cartStore.counters = ObservableMap.of(items);
// cartStore.comment = comment;
// cartStore.saveCartToHive();
// },
// ),
// );
// },
// child: Text('Переглянути останнє замовлення'),
// ),

// class LastOrderWidget extends StatefulWidget {
//   // final Function(Map<String, int>, String?) onRepeatOrder;
//   //required this.onRepeatOrder
//   const LastOrderWidget({super.key, });
//
//   @override
//   LastOrderWidgetState createState() => LastOrderWidgetState();
// }
//
// class LastOrderWidgetState extends State<LastOrderWidget> {
//   Map<String, int>? lastOrderItems;
//   String? lastComment;
//   double? totalPrice, deliveryPrice, finalPrice;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLastOrder();
//   }
//
//   Future<void> _loadLastOrder() async {
//     final lastOrderBox = await Hive.openBox<Map>('last_order');
//     final lastOrder = lastOrderBox.get('order');
//
//     if (lastOrder != null) {
//       setState(() {
//         lastOrderItems = Map<String, int>.from(lastOrder['items']);
//         lastComment = lastOrder['comment'];
//         totalPrice = lastOrder['totalPrice'];
//         deliveryPrice = lastOrder['deliveryPrice'];
//         finalPrice = lastOrder['finalPrice'];
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (lastOrderItems == null) {
//       return Center(child: Text('Немає останнього замовлення'));
//     }
//
//     return AlertDialog(
//       title: Text('Останнє замовлення'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('Загальна сума: ${totalPrice?.toStringAsFixed(2)} грн'),
//           Text('Доставка: ${deliveryPrice?.toStringAsFixed(2)} грн'),
//           Text('До сплати: ${finalPrice?.toStringAsFixed(2)} грн'),
//           if (lastComment != null && lastComment!.isNotEmpty)
//             Text('Коментар: $lastComment'),
//           SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               // widget.onRepeatOrder(lastOrderItems!, lastComment);
//               Navigator.pop(context);
//             },
//             child: Text('Повторити замовлення'),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text('Закрити'),
//         ),
//       ],
//     );
//   }
// }
