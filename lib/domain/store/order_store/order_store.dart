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

  // List<TimeOfDay> availableTimes = List.generate(
  //   22 * 2, // Для інтервалів кожні 30 хвилин
  //       (index) {
  //     final now = DateTime.now();
  //     const int startHour = 9; // Початок робочого часу
  //     const int endHour = 20; // Кінець робочого часу
  //     const int extendedEndHour = 21; // Кінець додаткових інтервалів
  //
  //     final int hours = startHour + ((index + 1) ~/ 2);
  //     final int minutes = ((index + 1) % 2 == 0) ? 0 : 30;
  //     final generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);
  //
  //     // Якщо зараз у робочий час
  //     if (now.hour >= startHour && now.hour < endHour) {
  //       // Додати інтервали від поточного часу до 21:00
  //       if (generatedTime.isAfter(now) && hours <= extendedEndHour) {
  //         return TimeOfDay(hour: hours, minute: minutes);
  //       }
  //     }
  //     // Якщо зараз не робочий час
  //     else if (now.hour >= endHour || now.hour < startHour) {
  //       // Додати всі інтервали для наступного дня з 9:30 до 20:00
  //       if (hours >= startHour && hours <= endHour) {
  //         return TimeOfDay(hour: hours, minute: minutes);
  //       }
  //     }
  //     return null;
  //   },
  // ).whereType<TimeOfDay>().toList();
  //
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
    isPhoneNumberValid = RegExp(r'^\+380\d{9}$').hasMatch(phone);
  }

  List<TimeOfDay> availableTimes = List.generate(
    22 * 2, // Для інтервалів кожні 30 хвилин
        (index) {
      final now = DateTime.now();
      const int startHour = 9; // Початок робочого часу
      const int endHour = 20; // Кінець робочого часу
      const int extendedEndHour = 21; // Кінець додаткових інтервалів

      final int hours = startHour + ((index + 1) ~/ 2);
      final int minutes = ((index + 1) % 2 == 0) ? 0 : 30;

      // Базова дата (залежить від поточного часу)
      DateTime generatedTime;
      if (now.hour >= endHour) {
        // Якщо час замовлення після 20:00, додаємо 1 день до дати доставки
        generatedTime = DateTime(now.year, now.month, now.day + 1, hours, minutes);
      } else {
        generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);
      }

      // Формуємо список доступних інтервалів
      if (now.hour >= startHour && now.hour < endHour) {
        if (generatedTime.isAfter(now) && hours <= extendedEndHour) {
          return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
        }
      } else if (now.hour >= endHour || now.hour < startHour) {
        if (hours >= startHour && hours <= endHour) {
          return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
        }
      }

      return null;
    },
  ).whereType<TimeOfDay>().toList();

  List<TimeOfDay> availablePointTimes = List.generate(
    44,
        (index) {
      final now = DateTime.now();

      // Початковий час: 9:15
      int totalMinutes = 9 * 60 + 15 + index * 15;
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;

      // Генеруємо дату й час для інтервалу
      DateTime generatedTime;
      if (now.hour >= 20) {
        // Якщо час замовлення після 20:00, додаємо 1 день
        generatedTime = DateTime(now.year, now.month, now.day + 1, hours, minutes);
      } else {
        generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);
      }

      // Фільтруємо доступні інтервали
      if (now.hour >= 20 || now.hour < 9) {
        // Для замовлень після 20:00 чи до 9:00
        if (hours >= 9 && hours < 20) {
          return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
        }
      } else if (generatedTime.isAfter(now)) {
        // Для замовлень у робочий час
        return TimeOfDay(hour: generatedTime.hour, minute: generatedTime.minute);
      }

      return null;
    },
  ).whereType<TimeOfDay>().toList();



}




// List<String> availableTimes = List.generate(
//   22 * 2, // Для інтервалів кожні 30 хвилин
//       (index) {
//     final now = DateTime.now();
//     const int startHour = 9; // Початок робочого часу
//     const int endHour = 20; // Кінець робочого часу
//     const int extendedEndHour = 21; // Кінець додаткових інтервалів
//
//     final int hours = startHour + ((index + 1) ~/ 2);
//     final int minutes = ((index + 1) % 2 == 0) ? 0 : 30;
//
//     // Базова дата (залежить від поточного часу)
//     DateTime generatedTime;
//     if (now.hour >= endHour) {
//       // Якщо час замовлення після 20:00, додаємо 1 день до дати доставки
//       generatedTime = DateTime(now.year, now.month, now.day + 1, hours, minutes);
//     } else {
//       // Якщо час замовлення в робочий час або до 20:00
//       generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);
//     }
//
//     // Формуємо список доступних інтервалів
//     if (now.hour >= startHour && now.hour < endHour) {
//       // Додаємо інтервали для поточного дня
//       if (generatedTime.isAfter(now) && hours <= extendedEndHour) {
//         return generatedTime.toIso8601String().replaceFirst('T', ' ').split('.')[0];
//       }
//     } else if (now.hour >= endHour || now.hour < startHour) {
//       // Додаємо інтервали для наступного дня
//       if (hours >= startHour && hours <= endHour) {
//         return generatedTime.toIso8601String().replaceFirst('T', ' ').split('.')[0];
//       }
//     }
//
//     return null;
//   },
// ).whereType<String>().toList();
//
// List<String> availablePointTimes = List.generate(
//   44,
//       (index) {
//     final now = DateTime.now();
//
//     // Початковий час: 9:15
//     int totalMinutes = 9 * 60 + 15 + index * 15;
//     int hours = totalMinutes ~/ 60;
//     int minutes = totalMinutes % 60;
//
//     // Генеруємо дату й час для інтервалу
//     DateTime generatedTime;
//     if (now.hour >= 20) {
//       // Якщо час замовлення після 20:00, додаємо 1 день
//       generatedTime = DateTime(now.year, now.month, now.day + 1, hours, minutes);
//     } else {
//       // Якщо час замовлення в робочий час або до 20:00
//       generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);
//     }
//
//     // Фільтруємо доступні інтервали
//     if (now.hour >= 20 || now.hour < 9) {
//       // Для замовлень після 20:00 чи до 9:00
//       if (hours >= 9 && hours < 20) {
//         return generatedTime.toIso8601String().replaceFirst('T', ' ').split('.')[0];
//       }
//     } else if (generatedTime.isAfter(now)) {
//       // Для замовлень у робочий час
//       return generatedTime.toIso8601String().replaceFirst('T', ' ').split('.')[0];
//     }
//
//     return null;
//   },
// ).whereType<String>().toList();