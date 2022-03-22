import 'package:dio/dio.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';

import 'handle_errors.dart';

DialogService _dialogService = locator<DialogService>();

/// Handle Dio Errors
///
/// Handle all errors specific to the [Dio] library
///
void handleDioErrors(DioError error) {
  if (error.type == DioErrorType.other) {
    _dialogService.showErrorDialog(
      title: "Message",
      message: "Check your internet connection!",
    );
    return;
  }

  if (error.response!.data is! Map) {
    _dialogService.showErrorDialog(
      title: "Message",
      message: "Failed to communicate with server!",
    );
    return;
  }

  try {
    switch (error.response!.statusCode) {
      case 204:
        _dialogService.showErrorDialog(
          title: "Message",
          message: "Requested content was not found!",
        );
        break;
      case 400:
        // handleApiResponseErrors(apiResponse.info);
        _dialogService.showErrorDialog(
          title: "Message",
          message: "Could not process your data. Check submitted information!",
        );
        break;
      case 404:
        _dialogService.showErrorDialog(title: "Message", message: "Not Found!");
        break;
      case 406:
        _dialogService.showErrorDialog(
          title: "Message",
          message: "Check the details you provided!",
        );
        break;
      case 500:
        _dialogService.showErrorDialog(
          title: "Message",
          message: "Failed to process your request. Try again!",
        );
        break;
      default:
        _dialogService.showErrorDialog(
          title: "Unexpected Exception",
          message: "Try again!",
        );
    }
  } catch (errors) {
    print(errors);
    print(error.response);

    if (error.response!.data['errors'] != null) {
      handleApiResponseErrors(error.response!.data['errors']);
    } else if (error.response!.data['message'] != null) {
      handleApiResponseErrors(error.response!.data['message']);
    }
  }
}
