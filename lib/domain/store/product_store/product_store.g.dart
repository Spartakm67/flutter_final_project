// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductStore on ProductStoreBase, Store {
  Computed<int>? _$totalItemsComputed;

  @override
  int get totalItems =>
      (_$totalItemsComputed ??= Computed<int>(() => super.totalItems,
              name: 'ProductStoreBase.totalItems'))
          .value;
  Computed<double>? _$totalPriceComputed;

  @override
  double get totalPrice =>
      (_$totalPriceComputed ??= Computed<double>(() => super.totalPrice,
              name: 'ProductStoreBase.totalPrice'))
          .value;

  late final _$productsAtom =
      Atom(name: 'ProductStoreBase.products', context: context);

  @override
  ObservableList<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$cachedProductsAtom =
      Atom(name: 'ProductStoreBase.cachedProducts', context: context);

  @override
  Map<String, List<Product>> get cachedProducts {
    _$cachedProductsAtom.reportRead();
    return super.cachedProducts;
  }

  @override
  set cachedProducts(Map<String, List<Product>> value) {
    _$cachedProductsAtom.reportWrite(value, super.cachedProducts, () {
      super.cachedProducts = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ProductStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$selectedCategoryIdAtom =
      Atom(name: 'ProductStoreBase.selectedCategoryId', context: context);

  @override
  String? get selectedCategoryId {
    _$selectedCategoryIdAtom.reportRead();
    return super.selectedCategoryId;
  }

  @override
  set selectedCategoryId(String? value) {
    _$selectedCategoryIdAtom.reportWrite(value, super.selectedCategoryId, () {
      super.selectedCategoryId = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'ProductStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$isFetchingAtom =
      Atom(name: 'ProductStoreBase.isFetching', context: context);

  @override
  bool get isFetching {
    _$isFetchingAtom.reportRead();
    return super.isFetching;
  }

  @override
  set isFetching(bool value) {
    _$isFetchingAtom.reportWrite(value, super.isFetching, () {
      super.isFetching = value;
    });
  }

  late final _$fetchProductsAsyncAction =
      AsyncAction('ProductStoreBase.fetchProducts', context: context);

  @override
  Future<void> fetchProducts(String categoryProductId) {
    return _$fetchProductsAsyncAction
        .run(() => super.fetchProducts(categoryProductId));
  }

  late final _$loadProductsAsyncAction =
      AsyncAction('ProductStoreBase.loadProducts', context: context);

  @override
  Future<void> loadProducts({String? categoryProductId}) {
    return _$loadProductsAsyncAction
        .run(() => super.loadProducts(categoryProductId: categoryProductId));
  }

  late final _$ProductStoreBaseActionController =
      ActionController(name: 'ProductStoreBase', context: context);

  @override
  void loadFromCache(String categoryId) {
    final _$actionInfo = _$ProductStoreBaseActionController.startAction(
        name: 'ProductStoreBase.loadFromCache');
    try {
      return super.loadFromCache(categoryId);
    } finally {
      _$ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCache() {
    final _$actionInfo = _$ProductStoreBaseActionController.startAction(
        name: 'ProductStoreBase.clearCache');
    try {
      return super.clearCache();
    } finally {
      _$ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
cachedProducts: ${cachedProducts},
isLoading: ${isLoading},
selectedCategoryId: ${selectedCategoryId},
error: ${error},
isFetching: ${isFetching},
totalItems: ${totalItems},
totalPrice: ${totalPrice}
    ''';
  }
}
