import 'package:mobx/mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';
import 'package:flutter_final_project/data/models/hive/product_counter_hive.dart';

part 'cart_store.g.dart';

class CartStore = CartStoreBase with _$CartStore;

abstract class CartStoreBase with Store {
  final ProductStore productStore;
  final OrderStore orderStore;
  CartStoreBase(this.productStore, this.orderStore);

  @observable
  ObservableMap<String, int> counters = ObservableMap<String, int>();

  @observable
  ObservableList<ProductCounterHive> cartItems =
      ObservableList<ProductCounterHive>();

  @computed
  ObservableList<Product> get products => productStore.products;

  @observable
  late Box<Map> hiveBox;

  @observable
  late Box<ProductCounterHive> productHiveBox;

  @observable
  String? comment;

  @observable
  late Box<String> commentsBox;

  @computed
  int get totalItems => counters.values.fold(0, (prev, next) => prev + next);

  @action
  Future<void> initHive() async {
    hiveBox = await Hive.openBox<Map>('cart');
    commentsBox = await Hive.openBox<String>('comments');
    productHiveBox = await Hive.openBox<ProductCounterHive>('cartProducts');
    loadCartFromHive();
    loadCommentFromHive();
  }

  @action
  Future<void> loadCartFromHive() async {
    final storedItems = hiveBox.get('items') ?? {};

    counters = ObservableMap.of(
      storedItems.map((key, value) => MapEntry(key, value as int)),
    );

    cartItems = ObservableList.of(productHiveBox.values.toList());
  }

  @action
  Future<void> saveCartToHive() async {
    await hiveBox.put(
      'items',
      counters.map((key, value) => MapEntry(key, value)),
    );

    await productHiveBox.clear();
    for (var item in cartItems) {
      await productHiveBox.add(item);
    }
  }

  @action
  Future<void> saveCommentToHive(String? comment) async {
    this.comment = comment;
    await commentsBox.put('comment', comment ?? '');
  }

  @action
  Future<void> loadCommentFromHive() async {
    final storedComment = commentsBox.get('comment');
    comment = storedComment ?? '';
  }

  @action
  void incrementCounter(String productId) {
    counters[productId] = (counters[productId] ?? 0) + 1;

    if (counters[productId] == 1) {
      final product = _getProduct(productId);
      cartItems.add(
        ProductCounterHive(
          productId: productId,
          productName: product.productName,
          price: product.price,
          photo: product.photo,
        ),
      );
    }
    saveCartToHive();
  }

  @action
  void decrementCounter(String productId) {
    if ((counters[productId] ?? 0) > 0) {
      counters[productId] = counters[productId]! - 1;

      if (counters[productId] == 0) {
        cartItems.removeWhere((item) => item.productId == productId);
      }
      saveCartToHive();
    }
  }

  @action
  Future<void> clearCart() async {
    counters.clear();
    cartItems.clear();
    await hiveBox.delete('items');
    await hiveBox.delete('totalPrice');
    await productHiveBox.clear();
  }

  Product _getProduct(String productId) {
    return productStore.products.firstWhere(
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
  }

  @computed
  double get totalCombinedOrderPrice {
    return cartItems.fold(0.0, (sum, item) {
      return sum + (item.price / 100) * getItemCount(item.productId);
    });
  }

  bool isItemInCart(String productId) {
    return counters.containsKey(productId) && counters[productId]! > 0;
  }

  int getItemCount(String productId) {
    return counters[productId] ?? 0;
  }

  Future<void> closeHive() async {
    await hiveBox.close();
    await productHiveBox.close();
    await commentsBox.close();
  }

  @action
  Future<void> resetCart() async {
    counters.clear();
    cartItems.clear();
    await hiveBox.clear();
    await productHiveBox.clear();
    await commentsBox.clear();
  }

  @computed
  double get deliveryPrice {
    if (!orderStore.isDelivery) {
      return 0.0;
    }
    return totalCombinedOrderPrice >= 350 ? 0.0 : 50.0;
  }

  @computed
  double get finalOrderPrice {
    return totalCombinedOrderPrice + deliveryPrice;
  }


  @action
  Future<void> completeOrder() async {
    // Тут можна виконати дії після виконання замовлення
    await resetCart();  // Очистити корзину та коментарі
    // Інші дії, наприклад, збереження інформації про замовлення
  }
}
