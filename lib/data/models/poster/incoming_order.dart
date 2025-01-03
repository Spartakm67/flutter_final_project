class IncomingOrder {
  final String point;
  final String phone;
  final String? address;
  final List<Product> products;
  final String? comment;
  final String paymentMethod;

  IncomingOrder({
    required this.point,
    required this.phone,
    this.address,
    required this.products,
    this.comment,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'spot_id': int.tryParse(point) ?? 1,
      'phone': phone,
      'address': address,
      'products': products.map((product) => product.toJson()).toList(),
      'comment': comment,
      'payment_method': paymentMethod,
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
