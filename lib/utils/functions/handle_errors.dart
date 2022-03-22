import 'package:flutter/material.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';

DialogService _dialogService = locator<DialogService>();

/// Handle API Response Errors
///
/// Methods helps to handle different error
/// situations by displaying specific error
/// messages
///
void handleApiResponseErrors(Map messages) {
  debugPrint(messages.toString());
  if (messages['errors'] is Map && messages['errors'] != null) {
    Map errorMessages = messages['errors'];
    errorMessages.forEach((key, value) {
      if (value is List) {
        for (var errorValue in value) {
          if (!(errorValue is bool)) {
            if (!(errorValue == "False")) {
              _dialogService.showErrorDialog(
                title: "Message",
                message: errorValue,
              );
            }
          }
        }
      } else {
        if (value is! bool) {
          if (!(value == "False")) {
            _dialogService.showErrorDialog(
              title: "Message",
              message: "$value",
            );
          }
        }
      }
    });
  } else {
    _dialogService.showErrorDialog(
      title: "Message",
      message: "Something went wrong. Try again!",
    );
  }
}
