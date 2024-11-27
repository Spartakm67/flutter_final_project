import 'package:mobx/mobx.dart';

part 'home_screen_store.g.dart';

class HomeScreenStore = HomeScreenStoreBase with _$HomeScreenStore;

abstract class HomeScreenStoreBase with Store {
  @observable
  String phoneNumber = '';

  @observable
  bool isLoading = false;

  @action
  void setPhoneNumber(String value) {
    phoneNumber = value;
  }

  @action
  void setLoading(bool value) {
    isLoading = value;
  }
}
