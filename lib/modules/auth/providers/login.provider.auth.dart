import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  final String _emailHintText = "emailaddress@gmail.com";
  final String _passwordHintText = "Enter Password";

  bool _showPassword = false;

  set togglePassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  // Getters
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey get formKey => _formKey;
  String get emailHintText => _emailHintText;
  String get passwordHintText => _passwordHintText;
  bool get showPassword => _showPassword;
}
