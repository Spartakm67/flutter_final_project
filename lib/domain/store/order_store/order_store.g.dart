// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderStore on OrderStoreBase, Store {
  Computed<TimeOfDay>? _$selectedTimeComputed;

  @override
  TimeOfDay get selectedTime =>
      (_$selectedTimeComputed ??= Computed<TimeOfDay>(() => super.selectedTime,
              name: 'OrderStoreBase.selectedTime'))
          .value;
  Computed<String>? _$selectedPointComputed;

  @override
  String get selectedPoint =>
      (_$selectedPointComputed ??= Computed<String>(() => super.selectedPoint,
              name: 'OrderStoreBase.selectedPoint'))
          .value;

  late final _$orderBoxAtom =
      Atom(name: 'OrderStoreBase.orderBox', context: context);

  @override
  Box<OrderModelHive>? get orderBox {
    _$orderBoxAtom.reportRead();
    return super.orderBox;
  }

  @override
  set orderBox(Box<OrderModelHive>? value) {
    _$orderBoxAtom.reportWrite(value, super.orderBox, () {
      super.orderBox = value;
    });
  }

  late final _$_selectedTimeAtom =
      Atom(name: 'OrderStoreBase._selectedTime', context: context);

  @override
  TimeOfDay? get _selectedTime {
    _$_selectedTimeAtom.reportRead();
    return super._selectedTime;
  }

  @override
  set _selectedTime(TimeOfDay? value) {
    _$_selectedTimeAtom.reportWrite(value, super._selectedTime, () {
      super._selectedTime = value;
    });
  }

  late final _$_selectedPointAtom =
      Atom(name: 'OrderStoreBase._selectedPoint', context: context);

  @override
  String get _selectedPoint {
    _$_selectedPointAtom.reportRead();
    return super._selectedPoint;
  }

  @override
  set _selectedPoint(String value) {
    _$_selectedPointAtom.reportWrite(value, super._selectedPoint, () {
      super._selectedPoint = value;
    });
  }

  late final _$isPhoneNumberValidAtom =
      Atom(name: 'OrderStoreBase.isPhoneNumberValid', context: context);

  @override
  bool get isPhoneNumberValid {
    _$isPhoneNumberValidAtom.reportRead();
    return super.isPhoneNumberValid;
  }

  @override
  set isPhoneNumberValid(bool value) {
    _$isPhoneNumberValidAtom.reportWrite(value, super.isPhoneNumberValid, () {
      super.isPhoneNumberValid = value;
    });
  }

  late final _$initHiveAsyncAction =
      AsyncAction('OrderStoreBase.initHive', context: context);

  @override
  Future<void> initHive() {
    return _$initHiveAsyncAction.run(() => super.initHive());
  }

  late final _$saveOrderAsyncAction =
      AsyncAction('OrderStoreBase.saveOrder', context: context);

  @override
  Future<void> saveOrder(OrderModelHive order) {
    return _$saveOrderAsyncAction.run(() => super.saveOrder(order));
  }

  late final _$OrderStoreBaseActionController =
      ActionController(name: 'OrderStoreBase', context: context);

  @override
  void selectTime(TimeOfDay time) {
    final _$actionInfo = _$OrderStoreBaseActionController.startAction(
        name: 'OrderStoreBase.selectTime');
    try {
      return super.selectTime(time);
    } finally {
      _$OrderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectPoint(String point) {
    final _$actionInfo = _$OrderStoreBaseActionController.startAction(
        name: 'OrderStoreBase.selectPoint');
    try {
      return super.selectPoint(point);
    } finally {
      _$OrderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePhoneNumber(String phone) {
    final _$actionInfo = _$OrderStoreBaseActionController.startAction(
        name: 'OrderStoreBase.validatePhoneNumber');
    try {
      return super.validatePhoneNumber(phone);
    } finally {
      _$OrderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orderBox: ${orderBox},
isPhoneNumberValid: ${isPhoneNumberValid},
selectedTime: ${selectedTime},
selectedPoint: ${selectedPoint}
    ''';
  }
}
