import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

part 'order_store.g.dart';

class OrderStore = OrderStoreBase with _$OrderStore;

abstract class OrderStoreBase with Store {

  @observable
  Observable<TimeOfDay> _selectedTime = Observable(TimeOfDay(hour: 9, minute: 30));

  @computed
  TimeOfDay get selectedTime => _selectedTime.value;

  List<TimeOfDay> availableTimes = List.generate(
    23,
        (index) {
      int hours = 9 + (index ~/ 2);
      int minutes = (index % 2 == 0) ? 0 : 30;
      if (hours == 20 && minutes == 30) {
        minutes = 0;
      }
      return TimeOfDay(hour: hours, minute: minutes);
    },
  ).skip(1).toList();

  @action
  void selectTime(TimeOfDay time) {
    _selectedTime.value = time;
  }
}
