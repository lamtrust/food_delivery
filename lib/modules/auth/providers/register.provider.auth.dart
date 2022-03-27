import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  bool _showPassword = false;

  set togglePassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  // Getters
  TextEditingController get emailController => _emailController;
  TextEditingController get nameController => _nameController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey get formKey => _formKey;
  bool get showPassword => _showPassword;
}
