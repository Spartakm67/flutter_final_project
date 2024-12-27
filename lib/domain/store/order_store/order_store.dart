import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_final_project/data/models/hive/order_model_hive.dart';

part 'order_store.g.dart';

class OrderStore = OrderStoreBase with _$OrderStore;

abstract class OrderStoreBase with Store {

  @observable
  Box<OrderModelHive>? orderBox;

  @action
  Future<void> initHive() async {
    orderBox = await Hive.openBox<OrderModelHive>('orders');
  }

  @action
  Future<void> saveOrder(OrderModelHive order) async {
    if (orderBox != null) {
      await orderBox!.add(order);
    } else {
      throw Exception('OrderBox is not initialized');
    }
  }

  // @action
  // Future<List<OrderModelHive>> getOrders() async {
  //   if (orderBox != null) {
  //     return orderBox!.values.toList();
  //   } else {
  //     throw Exception('OrderBox is not initialized');
  //   }
  // }

  @observable
  TimeOfDay? _selectedTime;

  @computed
  TimeOfDay get selectedTime =>
      _selectedTime ?? TimeOfDay.fromDateTime(DateTime.now());

  List<TimeOfDay> availableTimes = List.generate(
    23,
        (index) {
      final now = DateTime.now();

      int hours = 9 + (index ~/ 2);
      int minutes = (index % 2 == 0) ? 0 : 30;

      DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);

      if (now.hour >= 20 || now.hour < 9) {
        if (hours < 20) {
          return TimeOfDay(hour: hours, minute: minutes);
        }
      }
      else if (generatedTime.isAfter(now)) {
        return TimeOfDay(hour: hours, minute: minutes);
      }
      return null;
    },
  ).whereType<TimeOfDay>().toList();

  List<TimeOfDay> availablePointTimes = List.generate(
    44,
        (index) {
      final now = DateTime.now();

      int totalMinutes = 9 * 60 + 15 + index * 15;
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;

      DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);

      if (now.hour >= 20 || now.hour < 9) {
        if (hours < 20) {
          return TimeOfDay(hour: hours, minute: minutes);
        }
      }
      else if (generatedTime.isAfter(now)) {
        return TimeOfDay(hour: hours, minute: minutes);
      }
      return null;
    },
  ).whereType<TimeOfDay>().toList();

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

  @observable
  bool isPhoneNumberValid = false;

  @action
  void validatePhoneNumber(String phone) {
    isPhoneNumberValid = RegExp(r'^\+380\d{9}$').hasMatch(phone);
  }
}
