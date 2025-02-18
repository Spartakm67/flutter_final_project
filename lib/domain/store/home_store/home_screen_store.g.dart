// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeScreenStore on HomeScreenStoreBase, Store {
  late final _$phoneNumberAtom =
      Atom(name: 'HomeScreenStoreBase.phoneNumber', context: context);

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'HomeScreenStoreBase.isLoading', context: context);

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

  late final _$HomeScreenStoreBaseActionController =
      ActionController(name: 'HomeScreenStoreBase', context: context);

  @override
  void setPhoneNumber(String value) {
    final _$actionInfo = _$HomeScreenStoreBaseActionController.startAction(
        name: 'HomeScreenStoreBase.setPhoneNumber');
    try {
      return super.setPhoneNumber(value);
    } finally {
      _$HomeScreenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$HomeScreenStoreBaseActionController.startAction(
        name: 'HomeScreenStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$HomeScreenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
phoneNumber: ${phoneNumber},
isLoading: ${isLoading}
    ''';
  }
}
