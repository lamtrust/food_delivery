import 'dart:async';
import 'dart:ui';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/configs/colors.config.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:food_delivery/widgets/error_dialog_container.dart';
import 'package:food_delivery/widgets/success_dialog_container.dart';

class DialogManager extends StatefulWidget {
  const DialogManager({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final DialogService _dialogService = locator<DialogService>();
  StreamSubscription<ConnectivityResult>? subscription;

  @override
  void initState() {
    super.initState();
    _dialogService.registerLoaderDialogListener(listener: _showDialog);
    _dialogService.registerErrorDialogListener(listener: _showErrorDialog);
    _dialogService.registerSuccessDialogListener(listener: _showSuccessDialog);
    _dialogService.registerNotificationListener(listener: _showNotification);
    _dialogService.registerDialogRemover(listener: _dismissDialog);
    // _dialogService.registerRefreshTokenListener(listener: _refreshToken);
    _dialogService.registerContext(context: context);
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _showErrorDialog(
          title: "Network Service",
          message:
              "This app requires an active internet connection i.e. either through Wi-Fi or Mobile Data!",
          buttonText: "SETTINGS",
          onButtonClick: () {
            context.goBack();
            AppSettings.openAppSettings();
          },
        );
      }
    });
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  void _showDialog({String? message = "Working on it ⏳"}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(ColorConfigs.PRIMARY_COLOR),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              message ?? "Working on it ⏳",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotification({required String message, bool isError = false}) {
    context.notification(message: message, isError: isError);
  }

  void _dismissDialog() {
    context.goBack();
  }

  void _showErrorDialog({
    required String title,
    required String message,
    String? buttonText,
    Function? onButtonClick,
    bool? isLogout = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            elevation: 5,
            child: ErrorDialogContainer(
              title: title,
              message: message,
              buttonText: buttonText,
              onButtonClick: onButtonClick,
              isLogout: isLogout,
            ),
          ),
        );
      },
    );
  }

  void _showSuccessDialog({
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            elevation: 5,
            child: SuccessDialogContainer(
              title: title,
              message: message,
            ),
          ),
        );
      },
    );
  }

  // Future<String> _refreshToken() async {
  //   await Provider.of<Auth>(context, listen: false).refreshAuthToken();
  //   return Provider.of<Auth>(context, listen: false).accessToken!;
  // }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
