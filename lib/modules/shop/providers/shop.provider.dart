import 'package:flutter/material.dart';
import 'package:food_delivery/modules/shop/controllers/auth_controller.dart';
import 'package:food_delivery/modules/shop/controllers/products.dart';
import 'package:food_delivery/modules/shop/controllers/profile_controller.dart';
import 'package:food_delivery/modules/shop/models/cart_item.model.dart';
import 'package:food_delivery/modules/shop/models/product.model.dart';
import 'package:food_delivery/modules/shop/models/profile.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/services/storage.service.dart';
import 'package:food_delivery/utils/extensions/iterations.extension.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class ShopProvider extends ChangeNotifier {
  final DialogService _dialogService = locator<DialogService>();
  final StorageService _storageService = locator<StorageService>();

  List<Product> _products = [];
  List<CartItem> _cart = [];
  List<Product> _favourites = [];
  bool _isUsd = true;

  ShopProvider() {
    String? token = _storageService.getFromDisk("token");
    Future.delayed(const Duration(seconds: 1), () => setToken = token);
  }

  // AUTHENTICATION BLOCK
  String? _token;
  Profile? _profile;

  set setToken(String? token) {
    _token = token;
    notifyListeners();
    _token != null ? getAuthenticatedProfile() : null;
  }

  getAuthenticatedProfile() async {
    Map<String, dynamic>? profile =
        await AuthController.getAuthenticatedProfile(token: _token!);
    if (profile != null) {
      _profile = Profile.fromJson(profile);
      notifyListeners();
    }
  }

  void logout() {
    _storageService.saveToDisk("token", null);
    _token = null;
    _profile = null;
    notifyListeners();
  }

  // END OF AUTHENTICATION BLOCK

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

  void clearCart() {
    _cart = [];
    notifyListeners();
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

  // ADDRESS BLOCK
  LatLng? _location;

  set setLocation(LatLng? data) {
    _location = data;
    notifyListeners();
  }

  Future<bool> saveAddress({
    required String name,
    required String phone,
    required String address,
    required String addressType,
  }) async {
    if (_location == null) {
      _dialogService.showNotification(
        message: "Please select an exact location",
        isError: true,
      );
      return false;
    }
    return await ProfileController.saveAddress(
      name: name,
      phone: phone,
      address: address,
      latitude: _location!.latitude,
      longitude: _location!.longitude,
      addressType: addressType,
      token: _token!,
    );
  }

  List<Map<String, dynamic>> _addresses = [];

  Future<List<Map<String, dynamic>>?> getAddresses() async {
    List<Map<String, dynamic>>? data = await ProfileController.getAddresses(
      token: _token!,
    );

    if (data != null && data.isNotEmpty) {
      _addresses = data;
    }

    return data;
  }

  // END OF ADDRESS BLOCK

  // CHECKOUT

  Future<bool> checkout({
    required int deliveryAddressId,
    required String paymentMethod,
    String? phoneNumber,
    String? paymentType,
  }) async {
    String? orderId = await ProductsController.checkout(
      access: _token!,
      deliveryAddressId: deliveryAddressId,
      paymentMethod: paymentMethod,
      cart: _cart,
    );

    if (orderId != null) {
      // was payment method paynow
      if (paymentMethod == "Paynow") {
        await ProductsController.initiatePayment(
          access: _token!,
          orderId: orderId,
          phoneNumber: "$phoneNumber",
          paymentType: "$paymentType",
          cartTotal: cartTotal.rtgsAmount,
        );

        return true;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  // END OF CHECKOUT

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

  void toggleCurrency() {
    _isUsd = !_isUsd;
    notifyListeners();
  }

  List<Product> get favourites => _favourites;
  String? get token => _token;
  bool get authenticated => _token != null;
  Profile? get profile => _profile;
  LatLng? get location => _location;
  bool get isUsd => _isUsd;
}

extension ConvertedRate on double {
  double get rtgsAmount => this * 750;
}
