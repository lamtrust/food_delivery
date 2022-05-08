import 'package:flutter/material.dart';
import 'package:food_delivery/modules/shop/controllers/auth_controller.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/services/storage.service.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:provider/provider.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final StorageService _storageService = locator<StorageService>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _showPassword = false;

  set togglePassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    String? token = await AuthController.register(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
    );

    if (token != null) {
      locator<DialogService>().showSuccessDialog(
        title: "Success",
        message: "Registration Successful",
      );

      final storeProvider = Provider.of<ShopProvider>(context, listen: false);
      _storageService.saveToDisk("token", token);
      storeProvider.setToken = token;
      context.goBack();
    }
  }

  // Getters
  TextEditingController get emailController => _emailController;
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get phoneController => _phoneController;

  GlobalKey get formKey => _formKey;
  bool get showPassword => _showPassword;
}
