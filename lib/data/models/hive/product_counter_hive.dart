import 'package:hive/hive.dart';

part 'product_counter_hive.g.dart';

@HiveType(typeId: 0)
class ProductCounterHive extends HiveObject {
  @HiveField(0)
  String productId;

  @HiveField(1)
  String productName;

  @HiveField(2)
  double price;

  @HiveField(3)
  String? photo;


  ProductCounterHive({
    required this.productId,
    required this.productName,
    required this.price,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'photo': photo,
    };
  }

  factory ProductCounterHive.fromMap(Map<String, dynamic> map) {
    return ProductCounterHive(
      productId: map['productId'],
      productName: map['productName'],
      price: map['price'],
      photo: map['photo'],
    );
  }
}

