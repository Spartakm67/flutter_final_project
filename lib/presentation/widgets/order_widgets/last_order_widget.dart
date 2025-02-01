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
  List<Map<String, dynamic>>? lastOrderProducts;
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
      print('lastOrder: $lastOrder');

      setState(() {
        lastOrderItems = Map<String, int>.from(lastOrder['items'] ?? {});

        // Обробка cartItems з перевіркою на відсутність фото
        lastOrderProducts = lastOrder['cartItems'] != null
            ? (lastOrder['cartItems'] as List<dynamic>?)
            ?.map((item) {
          print('Before modification: $item'); // Лог до перетворення
          if (item is Map<String, dynamic>) {
            // Якщо фото відсутнє, зберігаємо значення null
            if (item['photo'] == null || item['photo']!.isEmpty) {
              item['photo'] = null; // Підставляємо null замість дефолтного фото
              print('Продукт без фото: ${item['productName']}');
            }

            // Якщо productId вже є рядком, перетворення не потрібно
            if (item['productId'] is! String) {
              item['productId'] = item['productId'].toString();
            }
            print('After modification: $item'); // Лог після перетворення
            return item;
          }
          return null;
        })
            .whereType<Map<String, dynamic>>()
            .toList()
            : []; // Якщо cartItems null, то повертаємо порожній список

        print('lastOrderProducts: $lastOrderProducts');

        lastComment = lastOrder['comment'];
        totalPrice = (lastOrder['totalPrice'] as num?)?.toDouble();
        deliveryPrice = (lastOrder['deliveryPrice'] as num?)?.toDouble();
        finalPrice = (lastOrder['finalPrice'] as num?)?.toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Попереднє замовлення', style: TextStyles.cartBottomText),
      ),
      body: lastOrderItems == null
          ? Center(
        child: Text('Немає попереднього замовлення',
            style: TextStyles.greetingsText),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Вартість продуктів: ${totalPrice?.toStringAsFixed(2)} грн',
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
              child: lastOrderProducts == null || lastOrderProducts!.isEmpty
                  ? Center(
                child: Text(
                  'Немає товарів у замовленні',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
                  : ListView(
                children: lastOrderProducts!.map<Widget>((item) {
                  int productId = int.tryParse(item['productId'].toString()) ?? 0;
                  int? quantity = lastOrderItems?[productId.toString()]; // Ключ у lastOrderItems - String

                  print('Перевірка продукту: ID=$productId, Назва=${item['productName']}, Кількість=$quantity');

                  if (quantity == null || quantity == 0) return const SizedBox(); // Пропускаємо товари з нульовою кількістю

                  return ListTile(
                    // leading: buildProductImage(item['photo']),
                    title: Text(item['productName'] ?? 'Невідомий товар'),
                    subtitle: Text('Кількість: $quantity'),
                  );
                }).toList(),
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

  // Widget buildProductImage(String? photoUrl) {
  //   if (photoUrl == null) {
  //     return const Icon(Icons.image, size: 50, color: Colors.grey);
  //   }
  //   return Image.network(photoUrl, width: 50, height: 50, fit: BoxFit.cover);
  // }
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
