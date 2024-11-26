class IncomingOrder {
  final int spotId;
  final String phone;
  final List<Product> products;

  IncomingOrder({
    required this.spotId,
    required this.phone,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'spot_id': spotId,
      'phone': phone,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class Product {
  final int productId;
  final int count;

  Product({required this.productId, required this.count});

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'count': count,
    };
  }
}