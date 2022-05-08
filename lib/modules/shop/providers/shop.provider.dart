import 'package:flutter/material.dart';
import 'package:food_delivery/modules/shop/controllers/products.dart';
import 'package:food_delivery/modules/shop/models/cart_item.model.dart';
import 'package:food_delivery/modules/shop/models/product.model.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/utils/extensions/iterations.extension.dart';
import 'package:uuid/uuid.dart';

class ShopProvider extends ChangeNotifier {
  final dialogService = locator<DialogService>();

  List<Product> _products = [];
  List<CartItem> _cart = [];
  List<Product> _favourites = [];

  String? _token;

  set setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  Future<List<Product>> getProducts() async {
    if (_products.isNotEmpty) {
      return _products;
    }
    Map<String, dynamic>? response = await ProductsController.getProducts();
    if (response != null) {
      try {
        List<Map<String, dynamic>> products = response['products']
            .map<Map<String, dynamic>>((p) => p as Map<String, dynamic>)
            .toList() as List<Map<String, dynamic>>;
        List<Product> _rProducts = [];
        for (Map<String, dynamic> product in products) {
          Product _product = Product(
            description: product['description'],
            id: product['id'].toString(),
            name: product['name'],
            price: product['price'].toDouble(),
            rating: 0,
            isFeatured: false,
            reviews: [],
            image: "http://tngrill.co.zw/storage/product/${product['image']}",
          );
          _rProducts.add(_product);
        }

        _products = _rProducts;
      } catch (error, stacktrace) {
        print("Error: $error -> $stacktrace");
      }
    }
    return _products;
  }

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

  int get cartTotalItems {
    int total = 0;
    for (CartItem item in _cart) {
      total += item.quantity;
    }

    return total;
  }

  List<Product> get favourites => _favourites;
  String? get token => _token;
  bool get authenticated => _token != null;
}
