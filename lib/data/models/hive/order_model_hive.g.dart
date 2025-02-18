// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelHiveAdapter extends TypeAdapter<OrderModelHive> {
  @override
  final int typeId = 1;

  @override
  OrderModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModelHive(
      name: fields[0] as String,
      phone: fields[1] as String,
      address: fields[2] as String?,
      status: fields[3] as String,
      point: fields[4] as String,
      time: fields[5] as TimeOfDay,
      paymentMethod: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OrderModelHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.point)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.paymentMethod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
