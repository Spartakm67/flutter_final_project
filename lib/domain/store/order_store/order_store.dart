import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

part 'order_store.g.dart';

class OrderStore = OrderStoreBase with _$OrderStore;

abstract class OrderStoreBase with Store {

  // @observable
  // TimeOfDay _selectedTime = TimeOfDay(hour: 9, minute: 30);
  @observable
  TimeOfDay _selectedTime = TimeOfDay(
    hour: DateTime.now().hour,
    minute: DateTime.now().minute,
  );

  @computed
  TimeOfDay get selectedTime => _selectedTime;

  // List<TimeOfDay> availableTimes = List.generate(
  //   23,
  //   (index) {
  //     int hours = 9 + (index ~/ 2);
  //     int minutes = (index % 2 == 0) ? 0 : 30;
  //     if (hours == 20 && minutes == 30) {
  //       minutes = 0;
  //     }
  //     return TimeOfDay(hour: hours, minute: minutes);
  //   },
  // ).skip(1).toList();

  // List<TimeOfDay> availableTimes = List.generate(
  //   23,
  //       (index) {
  //     final now = DateTime.now();
  //     int hours = 9 + (index ~/ 2);
  //     int minutes = (index % 2 == 0) ? 0 : 30;
  //
  //     if (now.hour > hours || (now.hour == hours && now.minute > minutes)) {
  //       if (minutes == 0) {
  //         minutes = 30;
  //       } else {
  //         hours += 1;
  //         minutes = 0;
  //       }
  //     }
  //     DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);
  //
  //     return generatedTime.isAfter(now)
  //         ? TimeOfDay(hour: hours, minute: minutes)
  //         : null;
  //   },
  // ).whereType<TimeOfDay>().toList();


  // List<TimeOfDay> availablePointTimes = List.generate(
  //   44,
  //       (index) {
  //     int totalMinutes = 9 * 60 + 15 + index * 15;
  //     int hours = totalMinutes ~/ 60;
  //     int minutes = totalMinutes % 60;
  //     return TimeOfDay(hour: hours, minute: minutes);
  //   },
  // ).skip(1).toList();

  // List<TimeOfDay> availablePointTimes = List.generate(
  //     44,
  //         (index) {
  //       final now = DateTime.now();
  //       int totalMinutes = 9 * 60 + 15 + index * 15;
  //       int hours = totalMinutes ~/ 60;
  //       int minutes = totalMinutes % 60;
  //       DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);
  //       return generatedTime.isAfter(now) ? TimeOfDay(hour: hours, minute: minutes) : null;
  //     },
  //   ).whereType<TimeOfDay>().toList();


  List<TimeOfDay> availableTimes = List.generate(
    23,
        (index) {
      final now = DateTime.now();
      int hours = 9 + (index ~/ 2);
      int minutes = (index % 2 == 0) ? 0 : 30;

      // Генерація часу
      DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);

      // Перевірка на неробочий час
      if (now.hour >= 20 || now.hour < 9) {
        // Якщо зараз неробочий час, генеруємо час з 9:00
        if (hours < 20) {
          return TimeOfDay(hour: hours, minute: minutes);
        }
      } else if (generatedTime.isAfter(now)) {
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

      // Генерація часу
      DateTime generatedTime = DateTime(now.year, now.month, now.day, hours, minutes);

      // Перевірка на неробочий час
      if (now.hour >= 20 || now.hour < 9) {
        // Якщо зараз неробочий час, генеруємо час з 9:00
        if (hours < 20) {
          return TimeOfDay(hour: hours, minute: minutes);
        }
      } else if (generatedTime.isAfter(now)) {
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
}
