// import 'package:mobx/mobx.dart';
// part 'order_store.g.dart';
//
// class OrderStore = OrderStoreBase with _$OrderStore;
//
// abstract class OrderStoreBase with Store {
//   @observable
//   ObservableList<OrderItem> orderItems = ObservableList<OrderItem>();
//
//   @computed
//   double get totalPrice =>
//       orderItems.fold(0, (sum, item) => sum + item.price * item.quantity);
//
//   @computed
//   int get totalItems =>
//       orderItems.fold(0, (sum, item) => sum + item.quantity);
//
//   @action
//   void addItem(OrderItem item) {
//     final existingItem = orderItems.firstWhere(
//           (orderItem) => orderItem.id == item.id,
//       orElse: () => null,
//     );
//     if (existingItem != null) {
//       existingItem.quantity += 1;
//     } else {
//       orderItems.add(item);
//     }
//   }
//
//   @action
//   void removeItem(String itemId) {
//     orderItems.removeWhere((item) => item.id == itemId);
//   }
//
//   @action
//   void updateQuantity(String itemId, int quantity) {
//     final item = orderItems.firstWhere((item) => item.id == itemId);
//     if (item != null) {
//       item.quantity = quantity;
//     }
//   }
// }
//
// class OrderItem {
//   final String id;
//   final String name;
//   final double price;
//   int quantity;
//
//   OrderItem({
//     required this.id,
//     required this.name,
//     required this.price,
//     this.quantity = 1,
//   });
// }
