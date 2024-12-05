// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scroll_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScrollStore on ScrollStoreBase, Store {
  Computed<bool>? _$isButtonVisibleComputed;

  @override
  bool get isButtonVisible =>
      (_$isButtonVisibleComputed ??= Computed<bool>(() => super.isButtonVisible,
              name: 'ScrollStoreBase.isButtonVisible'))
          .value;

  late final _$scrollPositionAtom =
      Atom(name: 'ScrollStoreBase.scrollPosition', context: context);

  @override
  double get scrollPosition {
    _$scrollPositionAtom.reportRead();
    return super.scrollPosition;
  }

  @override
  set scrollPosition(double value) {
    _$scrollPositionAtom.reportWrite(value, super.scrollPosition, () {
      super.scrollPosition = value;
    });
  }

  late final _$ScrollStoreBaseActionController =
      ActionController(name: 'ScrollStoreBase', context: context);

  @override
  void updateScrollPosition(double position) {
    final _$actionInfo = _$ScrollStoreBaseActionController.startAction(
        name: 'ScrollStoreBase.updateScrollPosition');
    try {
      return super.updateScrollPosition(position);
    } finally {
      _$ScrollStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetScroll() {
    final _$actionInfo = _$ScrollStoreBaseActionController.startAction(
        name: 'ScrollStoreBase.resetScroll');
    try {
      return super.resetScroll();
    } finally {
      _$ScrollStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scrollPosition: ${scrollPosition},
isButtonVisible: ${isButtonVisible}
    ''';
  }
}
