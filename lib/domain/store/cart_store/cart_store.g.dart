// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on CartStoreBase, Store {
  Computed<ObservableList<Product>>? _$productsComputed;

  @override
  ObservableList<Product> get products => (_$productsComputed ??=
          Computed<ObservableList<Product>>(() => super.products,
              name: 'CartStoreBase.products'))
      .value;
  Computed<int>? _$totalItemsComputed;

  @override
  int get totalItems =>
      (_$totalItemsComputed ??= Computed<int>(() => super.totalItems,
              name: 'CartStoreBase.totalItems'))
          .value;
  Computed<double>? _$totalPriceComputed;

  @override
  double get totalPrice =>
      (_$totalPriceComputed ??= Computed<double>(() => super.totalPrice,
              name: 'CartStoreBase.totalPrice'))
          .value;

  late final _$countersAtom =
      Atom(name: 'CartStoreBase.counters', context: context);

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

  late final _$cartItemsAtom =
      Atom(name: 'CartStoreBase.cartItems', context: context);

  @override
  ObservableList<ProductCounterHive> get cartItems {
    _$cartItemsAtom.reportRead();
    return super.cartItems;
  }

  @override
  set cartItems(ObservableList<ProductCounterHive> value) {
    _$cartItemsAtom.reportWrite(value, super.cartItems, () {
      super.cartItems = value;
    });
  }

  late final _$totalCombinedOrderPriceAtom =
      Atom(name: 'CartStoreBase.totalCombinedOrderPrice', context: context);

  @override
  double get totalCombinedOrderPrice {
    _$totalCombinedOrderPriceAtom.reportRead();
    return super.totalCombinedOrderPrice;
  }

  @override
  set totalCombinedOrderPrice(double value) {
    _$totalCombinedOrderPriceAtom
        .reportWrite(value, super.totalCombinedOrderPrice, () {
      super.totalCombinedOrderPrice = value;
    });
  }

  late final _$hiveBoxAtom =
      Atom(name: 'CartStoreBase.hiveBox', context: context);

  @override
  Box<Map<dynamic, dynamic>> get hiveBox {
    _$hiveBoxAtom.reportRead();
    return super.hiveBox;
  }

  bool _hiveBoxIsInitialized = false;

  @override
  set hiveBox(Box<Map<dynamic, dynamic>> value) {
    _$hiveBoxAtom
        .reportWrite(value, _hiveBoxIsInitialized ? super.hiveBox : null, () {
      super.hiveBox = value;
      _hiveBoxIsInitialized = true;
    });
  }

  late final _$productHiveBoxAtom =
      Atom(name: 'CartStoreBase.productHiveBox', context: context);

  @override
  Box<ProductCounterHive> get productHiveBox {
    _$productHiveBoxAtom.reportRead();
    return super.productHiveBox;
  }

  bool _productHiveBoxIsInitialized = false;

  @override
  set productHiveBox(Box<ProductCounterHive> value) {
    _$productHiveBoxAtom.reportWrite(
        value, _productHiveBoxIsInitialized ? super.productHiveBox : null, () {
      super.productHiveBox = value;
      _productHiveBoxIsInitialized = true;
    });
  }

  late final _$initHiveAsyncAction =
      AsyncAction('CartStoreBase.initHive', context: context);

  @override
  Future<void> initHive() {
    return _$initHiveAsyncAction.run(() => super.initHive());
  }

  late final _$loadCartFromHiveAsyncAction =
      AsyncAction('CartStoreBase.loadCartFromHive', context: context);

  @override
  Future<void> loadCartFromHive() {
    return _$loadCartFromHiveAsyncAction.run(() => super.loadCartFromHive());
  }

  late final _$saveCartToHiveAsyncAction =
      AsyncAction('CartStoreBase.saveCartToHive', context: context);

  @override
  Future<void> saveCartToHive() {
    return _$saveCartToHiveAsyncAction.run(() => super.saveCartToHive());
  }

  late final _$clearCartAsyncAction =
      AsyncAction('CartStoreBase.clearCart', context: context);

  @override
  Future<void> clearCart() {
    return _$clearCartAsyncAction.run(() => super.clearCart());
  }

  late final _$resetCartAsyncAction =
      AsyncAction('CartStoreBase.resetCart', context: context);

  @override
  Future<void> resetCart() {
    return _$resetCartAsyncAction.run(() => super.resetCart());
  }

  late final _$CartStoreBaseActionController =
      ActionController(name: 'CartStoreBase', context: context);

  @override
  void incrementCounter(String productId) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.incrementCounter');
    try {
      return super.incrementCounter(productId);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementCounter(String productId) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.decrementCounter');
    try {
      return super.decrementCounter(productId);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTotalCombinedOrderPrice(double categoryTotal) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.updateTotalCombinedOrderPrice');
    try {
      return super.updateTotalCombinedOrderPrice(categoryTotal);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetTotalCombinedOrderPrice() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.resetTotalCombinedOrderPrice');
    try {
      return super.resetTotalCombinedOrderPrice();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
counters: ${counters},
cartItems: ${cartItems},
totalCombinedOrderPrice: ${totalCombinedOrderPrice},
hiveBox: ${hiveBox},
productHiveBox: ${productHiveBox},
products: ${products},
totalItems: ${totalItems},
totalPrice: ${totalPrice}
    ''';
  }
}
