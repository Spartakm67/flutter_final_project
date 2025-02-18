import 'package:mobx/mobx.dart';

part 'scroll_store.g.dart';

class ScrollStore = ScrollStoreBase with _$ScrollStore;

abstract class ScrollStoreBase with Store {

  @observable
  double scrollPosition = 0.0;

  @computed
  bool get isButtonVisible => scrollPosition > 200.0;

  @action
  void updateScrollPosition(double position) {
    scrollPosition = position;
  }

  @action
  void resetScroll() {
    scrollPosition = 0.0;
  }
}
