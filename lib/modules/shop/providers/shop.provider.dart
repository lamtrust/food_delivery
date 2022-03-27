import 'package:flutter/material.dart';
import 'package:food_delivery/modules/shop/models/cart_item.model.dart';
import 'package:food_delivery/modules/shop/models/product.model.dart';
import 'package:uuid/uuid.dart';

class ShopProvider extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: const Uuid().v4(),
      name: "Coca-Cola",
      price: 2.5,
      rating: 1.5,
      description:
          "Coca-Cola is a carbonated soft drink manufactured by The Coca-Cola Company.",
      images: [
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397316/istockphoto-452813985-612x612-removebg-preview_rlvujm.png",
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397509/Screenshot_from_2022-03-27_18-08-39-removebg-preview_apu9g2.png",
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397512/Screenshot_from_2022-03-27_18-09-03-removebg-preview_vyv3qq.png",
      ],
      isFeatured: false,
      reviews: [],
    ),
    Product(
      id: const Uuid().v4(),
      name: "Fanta",
      price: 1.5,
      rating: 1.5,
      description:
          "Fanta is a carbonated soft drink manufactured by The Coca-Cola Company.",
      images: [
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397509/Screenshot_from_2022-03-27_18-08-39-removebg-preview_apu9g2.png",
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397316/istockphoto-452813985-612x612-removebg-preview_rlvujm.png",
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397512/Screenshot_from_2022-03-27_18-09-03-removebg-preview_vyv3qq.png",
      ],
      isFeatured: false,
      reviews: [],
    ),
    Product(
      id: const Uuid().v4(),
      name: "Coca-Cola",
      price: 1.5,
      rating: 1.5,
      description:
          "Coca-Cola is a carbonated soft drink manufactured by The Coca-Cola Company.",
      images: [
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397512/Screenshot_from_2022-03-27_18-09-03-removebg-preview_vyv3qq.png",
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397316/istockphoto-452813985-612x612-removebg-preview_rlvujm.png",
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397509/Screenshot_from_2022-03-27_18-08-39-removebg-preview_apu9g2.png",
      ],
      isFeatured: false,
      reviews: [],
    ),
    Product(
      id: const Uuid().v4(),
      name: "Coca-Cola",
      price: 1.5,
      rating: 1.5,
      description:
          "Coca-Cola is a carbonated soft drink manufactured by The Coca-Cola Company.",
      images: [
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397316/istockphoto-452813985-612x612-removebg-preview_rlvujm.png",
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397509/Screenshot_from_2022-03-27_18-08-39-removebg-preview_apu9g2.png",
        "https://res.cloudinary.com/iamngoni/image/upload/v1648397512/Screenshot_from_2022-03-27_18-09-03-removebg-preview_vyv3qq.png",
      ],
      isFeatured: false,
      reviews: [],
    ),
  ];
  List<CartItem> _cart = [];

  // Check if product exists in cart
  bool productExistsInCart(Product product) {
    return _cart.any((item) => item.product.id == product.id);
  }

  // Add product to cart
  void addProductToCart(Product product) {
    if (productExistsInCart(product)) {
      _cart.firstWhere((item) => item.product.id == product.id).increment();
    } else {
      _cart.add(CartItem(
        id: const Uuid().v4(),
        product: product,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  // Remove product from cart
  void removeProductFromCart(CartItem cartItem) {
    _cart.remove(cartItem);
    notifyListeners();
  }

  // Decrement cart item count
  void decrementCartItemCount(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.decrement();
    } else {
      removeProductFromCart(cartItem);
    }
    notifyListeners();
  }

  List<Product> get products => _products;
  List<CartItem> get cart => _cart;
  int get cartCount => _cart.length;
}
