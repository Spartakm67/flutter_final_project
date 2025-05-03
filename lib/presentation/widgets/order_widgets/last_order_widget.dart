import 'package:flutter/material.dart';
import 'package:flutter_final_project/data/models/hive/product_counter_hive.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/cart_preview_container.dart';
import 'package:flutter_final_project/presentation/widgets/loading_image_indicator.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:flutter_final_project/presentation/widgets/custom_dialog.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/services/url_helper.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

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
      setState(() {
        lastOrderItems = Map<String, int>.from(lastOrder['items'] ?? {});

        lastOrderProducts = lastOrder['cartItems'] != null
            ? (lastOrder['cartItems'] as List<dynamic>)
                .map((item) {
                  final Map<String, dynamic> itemMap =
                      Map<String, dynamic>.from(item);

                  if (itemMap['photo'] == null ||
                      (itemMap['photo'] is String &&
                          itemMap['photo'].trim().isEmpty)) {
                    itemMap['photo'] = '';
                  }

                  if (itemMap['productId'] is! String) {
                    itemMap['productId'] = itemMap['productId'].toString();
                  }

                  return itemMap;
                })
                .cast<Map<String, dynamic>>()
                .toList()
            : [];

        lastComment = lastOrder['comment'];
        totalPrice = (lastOrder['totalPrice'] as num?)?.toDouble();
        deliveryPrice = (lastOrder['deliveryPrice'] as num?)?.toDouble();
        finalPrice = (lastOrder['finalPrice'] as num?)?.toDouble();
      });
    }
  }

  void _repeatOrder(BuildContext context, CartStore cartStore) {
    if (lastOrderItems == null || lastOrderProducts == null) return;

    cartStore.counters = ObservableMap.of(lastOrderItems!);
    cartStore.cartItems = ObservableList.of(
      lastOrderProducts!.map((item) => ProductCounterHive.fromMap(item)),
    );
    cartStore.comment = lastComment ?? '';
    cartStore.saveCartToHive();

    Navigator.pop(context);

    CustomDialog.show(
      context: context,
      builder: (_) => const CartPreviewContainer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Замовляли раніше', style: TextStyles.cartBottomText),
      ),
      body: lastOrderItems == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Немає замовлення',
                  style: TextStyles.greetingsText,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Observer(
                builder: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Вартість продуктів: ${totalPrice?.toStringAsFixed(0)} грн',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Доставка: ${deliveryPrice?.toStringAsFixed(0)} грн',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'До сплати: ${finalPrice?.toStringAsFixed(0)} грн',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (lastComment != null && lastComment!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Коментар: $lastComment',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: lastOrderProducts == null ||
                              lastOrderProducts!.isEmpty
                          ? Center(
                              child: Text(
                                'Немає товарів у замовленні',
                                style: TextStyles.greetingsText,
                              ),
                            )
                          : ListView(
                              children: lastOrderProducts!.map<Widget>((item) {
                                int productId = int.tryParse(
                                      item['productId'].toString(),
                                    ) ??
                                    0;
                                int? quantity =
                                    lastOrderItems?[productId.toString()];

                                if (quantity == null || quantity == 0) {
                                  return const SizedBox();
                                }
                                return ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      UrlHelper.getFullImageUrl(item['photo']),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return LoadingImageIndicator(
                                          loadingProgress: loadingProgress,
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/default_image.webp',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  title: Text(
                                    item['productName'] ?? 'Невідомий товар',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  subtitle: Text(
                                    'Ціна: ${(item['price'] / 100).toStringAsFixed(0)} грн, кількість: $quantity шт',
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Observer(
                        builder: (_) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.black.withAlpha(100),
                          ),
                          onPressed: () => _repeatOrder(context, cartStore),
                          child: const Text(
                            'Замовити ще раз',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
