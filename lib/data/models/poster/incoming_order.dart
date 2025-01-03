class IncomingOrder {
  final int spotId;
  final String? point;
  final String phone;
  final String? address;
  final List<Product> products;
  final String? comment;
  final String paymentMethod;
  final int serviceMode;
  final int deliveryPrice;
  final String deliveryTime;

  IncomingOrder({
    required this.spotId,
    this.point,
    required this.phone,
    this.address,
    required this.products,
    this.comment,
    required this.paymentMethod,
    required this.serviceMode,
    required this.deliveryPrice,
    required this.deliveryTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'spot_id': spotId,
      'phone': phone,
      'client_address': address,
      // 'address': address,
      'products': products.map((product) => product.toJson()).toList(),
      'comment': comment,
      'fiscal_method': paymentMethod,
      'service_mode': serviceMode,
      // 'delivery_price': deliveryPrice,
      'delivery_price': serviceMode == 3 ? deliveryPrice : 0,
      'delivery_time': deliveryTime,
    };
  }
}

class Product {
  final String productId;
  final int count;

  Product({required this.productId, required this.count});

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'count': count,
    };
  }
}
