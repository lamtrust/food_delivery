import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';

class DioConnectivityRetrier {
  RequestOptions requestOptions;
  Dio dio;
  String refreshToken;
  DioConnectivityRetrier({
    required this.requestOptions,
    required this.dio,
    required this.refreshToken,
  });

  Future<Response> requestRetrier() async {
    debugPrint("***** Request retrier called");
    String token = await locator<DialogService>().refreshToken();

    requestOptions.headers = {"Authorization": "Bearer $token"};

    debugPrint("New token: $token");

    try {
      return await dio.request(
        requestOptions.path,
        options: Options(
          headers: requestOptions.headers,
          contentType: requestOptions.contentType,
          method: requestOptions.method,
          responseType: requestOptions.responseType,
        ),
        data: requestOptions.data,
        cancelToken: requestOptions.cancelToken,
        onReceiveProgress: requestOptions.onReceiveProgress,
        onSendProgress: requestOptions.onReceiveProgress,
        queryParameters: requestOptions.queryParameters,
      );
    } catch (e) {
      rethrow;
    }
  }
}
