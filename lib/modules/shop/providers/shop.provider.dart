import 'package:flutter/material.dart';
import 'package:food_delivery/modules/shop/models/cart_item.model.dart';
import 'package:food_delivery/modules/shop/models/product.model.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/utils/extensions/iterations.extension.dart';
import 'package:uuid/uuid.dart';

class ShopProvider extends ChangeNotifier {
  final dialogService = locator<DialogService>();

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
  List<Product> _favourites = [];

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

  // Decrement Product in cart
  void decrementProductQuantityInCart(Product product) {
    if (productExistsInCart(product)) {
      CartItem? item = getCartItemFromProduct(product);
      if (item != null) {
        decrementCartItemCount(item);
      }
    }
  }

  // Get product's related cart item from cart
  CartItem? getCartItemFromProduct(Product product) {
    return _cart
        .firstWhereOrNull((CartItem item) => item.product.id == product.id);
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

  // Get quantity of product in cart
  int getCartItemQuantity(Product product) {
    return _cart
            .firstWhereOrNull((item) => item.product.id == product.id)
            ?.quantity ??
        0;
  }

  // Get product item total cost in cart
  double totalProductCostInCart(Product product) {
    CartItem? item = getCartItemFromProduct(product);
    if (item != null) {
      return item.quantity * item.product.price;
    } else {
      return 0;
    }
  }

  // Increment cart item quantity
  void incrementCartItemQuantity(CartItem item) {
    item.increment();
    notifyListeners();
  }

  // Add to favourites
  void handleFavourites(Product product) {
    if (!isFavourite(product)) {
      _favourites.add(product);
    } else {
      _favourites.remove(product);
    }
    notifyListeners();
  }

  // Product exists in favourites
  bool isFavourite(Product product) {
    return _favourites.any((Product _) => _.id == product.id);
  }

  List<Product> get products => _products;
  List<CartItem> get cart => _cart;
  int get cartCount => _cart.length;
  double get cartTotal {
    double total = 0;
    for (CartItem item in _cart) {
      total += item.quantity * item.product.price;
    }

    return total;
  }

  List<Product> get favourites => _favourites;
}
