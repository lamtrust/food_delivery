import 'package:food_delivery/modules/shop/models/product.model.dart';

class CartItem {
  String id;
  Product product;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    this.quantity = 0,
  });

  void increment() {
    quantity++;
  }

  void decrement() {
    quantity--;
  }
}
