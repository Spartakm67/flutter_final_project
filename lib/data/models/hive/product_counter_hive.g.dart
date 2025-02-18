// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_counter_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductCounterHiveAdapter extends TypeAdapter<ProductCounterHive> {
  @override
  final int typeId = 0;

  @override
  ProductCounterHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductCounterHive(
      productId: fields[0] as String,
      productName: fields[1] as String,
      price: fields[2] as double,
      photo: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductCounterHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCounterHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
