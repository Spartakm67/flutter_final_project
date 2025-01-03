import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_final_project/data/models/hive/order_model_hive.dart';

part 'order_store.g.dart';

class OrderStore = OrderStoreBase with _$OrderStore;

abstract class OrderStoreBase with Store {

  @observable
  bool isDelivery = true;

  @observable
  bool isCash = true;

  @observable
  Box<OrderModelHive>? orderBox;

  @action
  Future<void> initHive() async {
    orderBox = await Hive.openBox<OrderModelHive>('orders');
  }

  @observable
  OrderModelHive? currentOrder;

  @action
  Future<void> updateOrder({
    String? name,
    String? phone,
    String? address,
    String? status,
    String? point,
    TimeOfDay? time,
    String? paymentMethod,
  }) async {
    currentOrder = OrderModelHive(
      name: name ?? currentOrder?.name ?? '',
      phone: phone ?? currentOrder?.phone ?? '',
      address: address ?? currentOrder?.address,
      status: status ?? currentOrder?.status ?? '',
      point: point ?? currentOrder?.point ?? '',
      time: time ?? currentOrder?.time ?? TimeOfDay.now(),
      paymentMethod: paymentMethod ?? currentOrder?.paymentMethod ?? '',
    );
    await saveOrder(currentOrder!);
  }

  @action
  void updateDelivery(bool value) {
    isDelivery = value;
    updateOrder(status: value ? "Доставлення" : "Самовивіз");
  }

  @action
  void updatePaymentMethod(bool value) {
    isCash = value;
    updateOrder(paymentMethod: value ? "Готівкою" : "Карткою");
  }

  @action
  Future<void> saveOrder(OrderModelHive order) async {
    await orderBox?.put('currentOrder', order);
  }

  @action
  Future<void> loadOrder() async {
    currentOrder = orderBox?.get('currentOrder');
    if (currentOrder != null) {
      isDelivery = currentOrder!.status == "Доставлення";
      isCash = currentOrder!.paymentMethod == "Готівкою";
      _selectedPoint = currentOrder!.point;
      _selectedTime = currentOrder!.time;
    }
  }

  @observable
  TimeOfDay? _selectedTime;

  @computed
  TimeOfDay get selectedTime =>
      _selectedTime ?? TimeOfDay.fromDateTime(DateTime.now());

  List<TimeOfDay> availableTimes = List.generate(
    24, // 24 інтервали для врахування часу від 9:30 до 21:00 включно
        (index) {
      final now = DateTime.now();

      // Починаємо з 9:30, а не з 9:00
      int hours = 9 + ((index + 1) ~/ 2);
      int minutes = ((index + 1) % 2 == 0) ? 0 : 30;

      // Генерований час
      DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);

      // Логіка перевірки: обмеження за часом і умовою
      if (now.hour >= 21 || now.hour < 9) {
        // Враховуємо лише години до 20:00
        if (hours < 21) {
          return TimeOfDay(hour: hours, minute: minutes);
        }
      } else if (generatedTime.isAfter(now)) {
        // Враховуємо лише майбутній час для проміжку 9:30–21:00
        if (hours <= 21) {
          return TimeOfDay(hour: hours, minute: minutes);
        }
      }

      // Повертаємо null, якщо час не відповідає умовам
      return null;
    },
  ).whereType<TimeOfDay>().toList();


  // List<TimeOfDay> availableTimes = List.generate(
  //   23,
  //       (index) {
  //     final now = DateTime.now();
  //
  //     int hours = 9 + (index ~/ 2);
  //     int minutes = (index % 2 == 0) ? 0 : 30;
  //
  //     DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);
  //
  //     if (now.hour >= 20 || now.hour < 9) {
  //       if (hours < 20) {
  //         return TimeOfDay(hour: hours, minute: minutes);
  //       }
  //     }
  //     else if (generatedTime.isAfter(now)) {
  //       return TimeOfDay(hour: hours, minute: minutes);
  //     }
  //     return null;
  //   },
  // ).whereType<TimeOfDay>().toList();

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
    updateOrder(time: time);
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
    updateOrder(point: point);
  }

  @observable
  bool isPhoneNumberValid = false;

  @action
  void validatePhoneNumber(String phone) {
    isPhoneNumberValid = RegExp(r'^\+380\d{9}$').hasMatch(phone);
  }
}
