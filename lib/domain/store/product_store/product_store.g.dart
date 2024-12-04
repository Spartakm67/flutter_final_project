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

  late final _$countersAtom =
      Atom(name: 'ProductStoreBase.counters', context: context);

  @override
  ObservableMap<String, int> get counters {
    _$countersAtom.reportRead();
    return super.counters;
  }

  @override
  set counters(ObservableMap<String, int> value) {
    _$countersAtom.reportWrite(value, super.counters, () {
      super.counters = value;
    });
  }

  late final _$initHiveAsyncAction =
      AsyncAction('ProductStoreBase.initHive', context: context);

  @override
  Future<void> initHive() {
    return _$initHiveAsyncAction.run(() => super.initHive());
  }

  late final _$saveCountersToHiveAsyncAction =
      AsyncAction('ProductStoreBase.saveCountersToHive', context: context);

  @override
  Future<void> saveCountersToHive() {
    return _$saveCountersToHiveAsyncAction
        .run(() => super.saveCountersToHive());
  }

  late final _$fetchProductsAsyncAction =
      AsyncAction('ProductStoreBase.fetchProducts', context: context);

  @override
  Future<void> fetchProducts(String categoryProductId) {
    return _$fetchProductsAsyncAction
        .run(() => super.fetchProducts(categoryProductId));
  }

  late final _$clearCountersAsyncAction =
      AsyncAction('ProductStoreBase.clearCounters', context: context);

  @override
  Future<void> clearCounters() {
    return _$clearCountersAsyncAction.run(() => super.clearCounters());
  }

  late final _$ProductStoreBaseActionController =
      ActionController(name: 'ProductStoreBase', context: context);

  @override
  void loadCountersFromHive() {
    final _$actionInfo = _$ProductStoreBaseActionController.startAction(
        name: 'ProductStoreBase.loadCountersFromHive');
    try {
      return super.loadCountersFromHive();
    } finally {
      _$ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementCounter(String productId) {
    final _$actionInfo = _$ProductStoreBaseActionController.startAction(
        name: 'ProductStoreBase.incrementCounter');
    try {
      return super.incrementCounter(productId);
    } finally {
      _$ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementCounter(String productId) {
    final _$actionInfo = _$ProductStoreBaseActionController.startAction(
        name: 'ProductStoreBase.decrementCounter');
    try {
      return super.decrementCounter(productId);
    } finally {
      _$ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
isLoading: ${isLoading},
selectedCategoryId: ${selectedCategoryId},
error: ${error},
isFetching: ${isFetching},
counters: ${counters},
totalItems: ${totalItems},
totalPrice: ${totalPrice}
    ''';
  }
}
