import 'package:mobx/mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';

part 'cart_store.g.dart';

class CartStore = CartStoreBase with _$CartStore;

abstract class CartStoreBase with Store {
  final ProductStore productStore;
  CartStoreBase(this.productStore);

  @observable
  ObservableMap<String, int> counters = ObservableMap<String, int>();

  @computed
  ObservableList<Product> get products => productStore.products;

  @observable
  double totalCombinedOrderPrice = 0.0;

  @observable
  late Box<Map> hiveBox;

  @computed
  int get totalItems => counters.values.fold(0, (prev, next) => prev + next);

  @action
  Future<void> initHive() async {
    hiveBox = await Hive.openBox<Map>('cart');
    loadCartFromHive();
  }

  @action
  Future<void> loadCartFromHive() async {
    final storedItems = hiveBox.get('items') ?? {};
    print('Завантажені з Hive дані: $storedItems');

    counters = ObservableMap.of(
      storedItems.map((key, value) => MapEntry(key, value as int)),
    );

    final totalPriceMap = hiveBox.get('totalPrice');
    totalCombinedOrderPrice = totalPriceMap?['value'] as double? ?? 0.0;
    print('Загальна сума після завантаження: $totalCombinedOrderPrice');
  }

  @action
  Future<void> saveCartToHive() async {
    await hiveBox.put(
      'items',
      counters.map((key, value) => MapEntry(key, value)),
    );
    await hiveBox.put('totalPrice', {'value': totalCombinedOrderPrice});
  }

  @action
  void incrementCounter(String productId) {
    counters[productId] = (counters[productId] ?? 0) + 1;
    totalCombinedOrderPrice += _getProductPrice(productId);
    saveCartToHive();
  }

  @action
  void decrementCounter(String productId) {
    if ((counters[productId] ?? 0) > 0) {
      counters[productId] = counters[productId]! - 1;
      totalCombinedOrderPrice -= _getProductPrice(productId);
      saveCartToHive();
    }
  }

  @action
  Future<void> clearCart() async {
    counters.clear();
    await hiveBox.delete('items');
    await hiveBox.delete('totalPrice');
  }

  double _getProductPrice(String productId) {
    final product = productStore.products.firstWhere(
      (p) => p.productId == productId,
      orElse: () => Product(
        categoryProductId: '',
        categoryName: '',
        productId: productId,
        productName: '',
        price: 0.0,
        cookingTime: 0,
        photo: '',
        photoOrigin: '',
        description: '',
        ingredients: [],
      ),
    );
    return product.price / 100;
  }

  @computed
  double get totalPrice {
    final total = counters.entries.fold(
      0.0,
          (sum, entry) {
        final productPrice = _getProductPrice(entry.key);
        return sum + (productPrice * entry.value);
      },
    );
    return total;
  }

  @action
  void updateTotalCombinedOrderPrice(double categoryTotal) {
    totalCombinedOrderPrice += categoryTotal;
  }

  bool isItemInCart(String productId) {
    return counters.containsKey(productId) && counters[productId]! > 0;
  }

  int getItemCount(String productId) {
    return counters[productId] ?? 0;
  }

  Future<void> closeHive() async {
    await hiveBox.close();
  }

  @action
  Future<void> resetCart() async {
    counters.clear();
    await hiveBox.clear();
  }

  @action
  void resetTotalCombinedOrderPrice() {
    totalCombinedOrderPrice = 0.0;
  }
}
