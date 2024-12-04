import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';
import 'package:flutter_final_project/services/poster_api/product_api_services.dart';
import 'package:flutter_final_project/data/models/hive/product_counter_hive.dart';

part 'product_store.g.dart';

class ProductStore = ProductStoreBase with _$ProductStore;

abstract class ProductStoreBase with Store {
  final ProductApiServices _apiService = ProductApiServices();

  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @observable
  bool isLoading = false;

  @observable
  String? selectedCategoryId;

  @observable
  String? error;

  @observable
  bool isFetching = false;

  @observable
  ObservableMap<String, int> counters = ObservableMap<String, int>();

  late Box<Map> hiveBox;

  @action
  Future<void> initHive() async {
    hiveBox = await Hive.openBox<Map>('counters');
    loadCountersFromHive();
  }

  @action
  void loadCountersFromHive() {
    final storedCounters = hiveBox.get('counters') ?? {};
    counters = ObservableMap.of(
      storedCounters.map((key, value) => MapEntry(key, value as int)),
    );
  }

  @action
  Future<void> saveCountersToHive() async {
    await hiveBox.put('counters', counters.map((key, value) => MapEntry(key, value)));
  }


  @action
  Future<void> fetchProducts(String categoryProductId) async {
    if (isFetching) return;
    isFetching = true;
    try {
      isLoading = true;
      error = null;
      selectedCategoryId = categoryProductId;
      final fetchedProducts =
          await _apiService.getProductsByCategory(categoryProductId);
      products = ObservableList.of(fetchedProducts);

      for (final product in products) {
        counters.putIfAbsent(product.productId, () => 0);
      }
      saveCountersToHive();
    } catch (e) {
      error = 'Помилка завантаження продуктів: $e';
    } finally {
      isLoading = false;
      isFetching = false;
    }
  }

  @action
  void incrementCounter(String productId) {
    counters[productId] = (counters[productId] ?? 0) + 1;
    saveCountersToHive();
  }

  @action
  void decrementCounter(String productId) {
    if ((counters[productId] ?? 0) > 0) {
      counters[productId] = counters[productId]! - 1;
      saveCountersToHive();
    }
  }

  @action
  Future<void> clearCounters() async {
    counters.clear();
    await hiveBox.delete('counters');
  }

  @computed
  int get totalItems {
    return counters.values.fold(0, (a, b) => a + b);
  }

  @computed
  double get totalPrice {
    return counters.entries.fold(
      0.0,
          (sum, entry) {
        final product = products.firstWhere(
              (p) => p.productId == entry.key,
          orElse: () => Product(
            categoryProductId: '',
            categoryName: '',
            productId: entry.key,
            productName: '',
            price: 0.0,
            cookingTime: 0,
            photo: '',
            photoOrigin: '',
            description: '',
            ingredients: [],
          ),
        );
        return sum + (entry.value * product.price)/100;
      },
    );
  }

}
