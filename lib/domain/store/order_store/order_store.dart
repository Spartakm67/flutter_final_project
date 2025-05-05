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

  @action
  void selectTime(TimeOfDay time) {
    _selectedTime = time;
    updateOrder(time: time);
  }

  @observable
  List<String> availablePoints = [
    'Майстерня млинців (просп. Соборності 7Б, Київ)',
    'Наступний заклад у стадії відкриття',
  ];

  @observable
  String _selectedPoint = '';

  @computed
  String get selectedPoint => _selectedPoint;

  OrderStoreBase() {
    _initializeDefaultPoint();
    }

  @action
  void _initializeDefaultPoint() {
    if (availablePoints.isNotEmpty) {
      _selectedPoint = availablePoints[0];
    }
  }

  @action
  void selectPoint(String point) {
    _selectedPoint = point;
    updateOrder(point: point);
  }

  @observable
  bool isPhoneNumberValid = false;


  @action
  void validatePhoneNumber(String phone) {
    isPhoneNumberValid = RegExp(r'^\+380[3-9]\d{8}$').hasMatch(phone);
  }

  @observable
  List<TimeOfDay> availableTimes = [];

  @observable
  List<TimeOfDay> availablePointTimes = [];


  @action
  void regenerateAvailableTimes() {
    final now = DateTime.now();
    const int startHour = 9;
    const int endHour = 20;
    const int extendedEndHour = 21;

    availableTimes = List.generate(
      22 * 2,
          (index) {
        final int hours = startHour + ((index + 1) ~/ 2);
        final int minutes = ((index + 1) % 2 == 0) ? 0 : 30;

        DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);
        if (now.hour >= endHour || now.hour < startHour) {
          generatedTime = generatedTime.add(const Duration(days: 1));
        }

        if (now.hour >= startHour && now.hour < endHour) {
          if (generatedTime.isAfter(now) && hours <= extendedEndHour) {
            return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
          }
        } else if (hours >= startHour && hours <= endHour) {
          return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
        }

        return null;
      },
    ).whereType<TimeOfDay>().toList();
  }

  @action
  void regenerateAvailablePointTimes() {
    final now = DateTime.now();

    availablePointTimes = List.generate(
      44,
          (index) {
        int totalMinutes = 9 * 60 + 15 + index * 15;
        int hours = totalMinutes ~/ 60;
        int minutes = totalMinutes % 60;

        DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);

        if (now.hour >= 20 || now.hour < 9) {
          generatedTime = generatedTime.add(const Duration(days: 1));
        }

        if ((now.hour >= 20 || now.hour < 9) && hours < 20) {
          return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
        } else if (generatedTime.isAfter(now)) {
          return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
        }

        return null;
      },
    ).whereType<TimeOfDay>().toList();
  }

}

// @observable
// List<TimeOfDay> availableTimes = List.generate(
//   22 * 2,
//       (index) {
//     final now = DateTime.now();
//     const int startHour = 9;
//     const int endHour = 20;
//     const int extendedEndHour = 21;
//
//     final int hours = startHour + ((index + 1) ~/ 2);
//     final int minutes = ((index + 1) % 2 == 0) ? 0 : 30;
//
//     DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);
//     if (now.hour >= endHour || now.hour < startHour) {
//       generatedTime = generatedTime.add(const Duration(days: 1));
//     }
//
//     if (now.hour >= startHour && now.hour < endHour) {
//
//       if (generatedTime.isAfter(now) && hours <= extendedEndHour) {
//         return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
//       }
//     }
//
//     else if (now.hour >= endHour || now.hour < startHour) {
//
//       if (hours >= startHour && hours <= endHour) {
//         return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
//       }
//     }
//     return null;
//   },
// ).whereType<TimeOfDay>().toList();
//
// @observable
// List<TimeOfDay> availablePointTimes = List.generate(
//   44,
//       (index) {
//     final now = DateTime.now();
//
//     int totalMinutes = 9 * 60 + 15 + index * 15;
//     int hours = totalMinutes ~/ 60;
//     int minutes = totalMinutes % 60;
//
//     DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);
//
//     if (now.hour >= 20 || now.hour < 9) {
//       generatedTime = generatedTime.add(const Duration(days: 1));
//     }
//
//     if (now.hour >= 20 || now.hour < 9) {
//       if (hours < 20) {
//         return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
//       }
//     }
//
//     else if (generatedTime.isAfter(now)) {
//       return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
//     }
//
//     return null;
//   },
// ).whereType<TimeOfDay>().toList();