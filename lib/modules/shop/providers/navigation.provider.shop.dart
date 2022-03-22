import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/modules/shop/pages/cart.page.shop.dart';
import 'package:food_delivery/modules/shop/pages/explore.page.shop.dart';
import 'package:food_delivery/modules/shop/pages/favourites.page.shop.dart';
import 'package:food_delivery/modules/shop/pages/home.page.shop.dart';
import 'package:food_delivery/modules/shop/pages/profile.page.shop.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const ExplorePage(),
    const CartPage(),
    const FavouritesPage(),
    const ProfilePage(),
  ];
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int get currentIndex => _currentIndex;
  List<Widget> get pages => _pages;
  PageController get pageController => _pageController;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
