import 'dart:async';

import 'package:flutter/cupertino.dart';

class DialogService {
  Function? _showLoaderDialogListener;
  Function? _showErrorDialogListener;
  Function? _showSuccessDialogListener;
  Completer? _dialogCompleter;
  Function? _removeDialog;
  Function? _showNotification;
  Function? _refreshToken;
  BuildContext? _context;

  /// Registration of listeners
  void registerLoaderDialogListener({required Function listener}) {
    _showLoaderDialogListener = listener;
  }

  void registerContext({required BuildContext context}) {
    _context = context;
  }

  void registerErrorDialogListener({required Function listener}) {
    _showErrorDialogListener = listener;
  }

  void registerSuccessDialogListener({required Function listener}) {
    _showSuccessDialogListener = listener;
  }

  void registerNotificationListener({required Function listener}) {
    _showNotification = listener;
  }

  void registerDialogRemover({required Function listener}) {
    _removeDialog = listener;
  }

  void registerRefreshTokenListener({required Function listener}) {
    _refreshToken = listener;
  }

  /// Methods to invoke the dialogs
  Future showLoaderDialog({String? message}) {
    _dialogCompleter = Completer();
    _showLoaderDialogListener!(message: message);
    return _dialogCompleter!.future;
  }

  Future showErrorDialog({
    required String title,
    required String message,
    String? buttonText,
    Function? onButtonClick,
    bool? isLogout = false,
  }) {
    _dialogCompleter = Completer();
    _showErrorDialogListener!(
      title: title,
      message: message,
      buttonText: buttonText,
      onButtonClick: onButtonClick,
      isLogout: isLogout,
    );
    return _dialogCompleter!.future;
  }

  Future showSuccessDialog({required String title, required String message}) {
    _dialogCompleter = Completer();
    _showSuccessDialogListener!(
      title: title,
      message: message,
    );
    return _dialogCompleter!.future;
  }

  void showNotification({required String message, bool isError = false}) {
    _showNotification!(message: message, isError: isError);
  }

  BuildContext? useContext() {
    return _context;
  }

  Future<String> refreshToken() {
    return _refreshToken!();
  }

  void dialogComplete() {
    _dialogCompleter!.complete();
    _removeDialog!();
    _dialogCompleter = null;
  }
}
