import 'package:mobx/mobx.dart';
import 'package:flutter_final_project/data/models/poster/product.dart';
import 'package:flutter_final_project/services/poster_api/product_api_services.dart';

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
        counters[product.productId] = 0;
      }
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
  }

  @action
  void decrementCounter(String productId) {
    if ((counters[productId] ?? 0) > 0) {
      counters[productId] = counters[productId]! - 1;
    }
  }
}
