import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

part 'order_store.g.dart';

class OrderStore = OrderStoreBase with _$OrderStore;

abstract class OrderStoreBase with Store {
  @observable
  TimeOfDay _selectedTime = TimeOfDay(hour: 9, minute: 30);

  @computed
  TimeOfDay get selectedTime => _selectedTime;

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
    _selectedTime = time;
  }

  List<String> availablePoints = [
    'Майстерня млинців (просп. Соборності 7Б, Київ)',
    'Наступний заклад у стадії відкриття',
  ];

  @observable
  String _selectedPoint = 'Майстерня млинців';

  @computed
  String get selectedPoint => _selectedPoint;

  @action
  void selectPoint(String point) {
    _selectedPoint = point;
  }
}
