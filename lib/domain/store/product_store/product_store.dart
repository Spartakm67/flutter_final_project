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
  Map<String, List<Product>> cachedProducts = {};

  @observable
  bool isLoading = false;

  @observable
  String? selectedCategoryId;

  @observable
  String? error;

  @observable
  bool isFetching = false;

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
      cachedProducts[categoryProductId] = fetchedProducts;
      if (cachedProducts.containsKey(categoryProductId)) {
        products = ObservableList.of(cachedProducts[categoryProductId]!);
      } else {
        final fetchedProducts =
        await _apiService.getProductsByCategory(categoryProductId);
        products = ObservableList.of(fetchedProducts);
        cachedProducts[categoryProductId] = fetchedProducts; // Кешування
      }
      // final fetchedProducts =
      //     await _apiService.getProductsByCategory(categoryProductId);
      // products = ObservableList.of(fetchedProducts);
    } catch (e) {
      error = 'Помилка завантаження продуктів: $e';
    } finally {
      isLoading = false;
      isFetching = false;
    }
  }

  @action
  void loadFromCache(String categoryId) {
    final cached = cachedProducts[categoryId];
    if (cached != null) {
      selectedCategoryId = categoryId;
      products = ObservableList.of(cached);
    }
  }


  @action
  Future<void> loadProducts({String? categoryProductId}) async {
    isLoading = true;
    error = null;

    if (categoryProductId != null) {
      await fetchProducts(categoryProductId);
    } else {
      try {
        final allProducts = await _apiService.getProductsByCategory('');
        products = ObservableList.of(allProducts);
        // print('LoadProducts ............$products');
      } catch (e) {
        error = 'Помилка завантаження всіх продуктів: $e';
      }
    }
    isLoading = false;
  }

  @computed
  int get totalItems => products.length;

  @computed
  double get totalPrice {
    return products.fold(0.0, (sum, product) => sum + product.price);
  }

  @action
  void clearCache() {
    cachedProducts.clear();
  }
}
