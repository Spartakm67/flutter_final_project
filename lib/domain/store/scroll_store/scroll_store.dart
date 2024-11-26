import 'package:mobx/mobx.dart';

part 'scroll_store.g.dart';

class ScrollStore = ScrollStoreBase with _$ScrollStore;

abstract class ScrollStoreBase with Store {

  @observable
  bool showScrollToTopButton = false;

  @action
  void updateScrollPosition(double offset) {
    showScrollToTopButton = offset > 200;
  }

}