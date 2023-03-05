import 'package:flutter/material.dart';
import 'package:food_delivery/modules/shop/controllers/auth_controller.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/services/storage.service.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final StorageService _storageService = locator<StorageService>();

  final String _emailHintText = "emailaddress@gmail.com";
  final String _passwordHintText = "Enter Password";

  bool _showPassword = false;

  set togglePassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    String? token = await AuthController.login(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (token != null) {
      final shopProvider = Provider.of<ShopProvider>(context, listen: false);
      _storageService.saveToDisk("token", token);
      shopProvider.setToken = token;
      context.goBack();
    }
  }

  // Getters
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey get formKey => _formKey;
  String get emailHintText => _emailHintText;
  String get passwordHintText => _passwordHintText;
  bool get showPassword => _showPassword;
}
