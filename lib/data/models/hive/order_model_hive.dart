import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'order_model_hive.g.dart';

@HiveType(typeId: 1)
class OrderModelHive {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phone;

  @HiveField(2)
  final String? address;

  @HiveField(3)
  final String status;

  @HiveField(4)
  final String point;

  @HiveField(5)
  final TimeOfDay time;

  @HiveField(6)
  final String paymentMethod;

  OrderModelHive({
    required this.name,
    required this.phone,
    this.address,
    required this.status,
    required this.point,
    required this.time,
    required this.paymentMethod,
  });
}
