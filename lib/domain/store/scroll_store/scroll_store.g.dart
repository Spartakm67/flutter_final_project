// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scroll_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScrollStore on ScrollStoreBase, Store {
  late final _$showScrollToTopButtonAtom =
      Atom(name: 'ScrollStoreBase.showScrollToTopButton', context: context);

  @override
  bool get showScrollToTopButton {
    _$showScrollToTopButtonAtom.reportRead();
    return super.showScrollToTopButton;
  }

  @override
  set showScrollToTopButton(bool value) {
    _$showScrollToTopButtonAtom.reportWrite(value, super.showScrollToTopButton,
        () {
      super.showScrollToTopButton = value;
    });
  }

  late final _$ScrollStoreBaseActionController =
      ActionController(name: 'ScrollStoreBase', context: context);

  @override
  void updateScrollPosition(double offset) {
    final _$actionInfo = _$ScrollStoreBaseActionController.startAction(
        name: 'ScrollStoreBase.updateScrollPosition');
    try {
      return super.updateScrollPosition(offset);
    } finally {
      _$ScrollStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showScrollToTopButton: ${showScrollToTopButton}
    ''';
  }
}
