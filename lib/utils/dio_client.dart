import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dio_connectivity_retrier.dart';

class DioClient {
  final String _accessToken;
  final String _refreshToken;
  final Dio _dio = Dio();

  DioClient(this._accessToken, this._refreshToken) {
    _dio
      ..httpClientAdapter
      ..options.headers = {
        Headers.contentTypeHeader: "application/json",
        "Authorization": "Bearer $_accessToken",
        "Client": "${Platform.isAndroid ? 'Android' : 'iOS'}-Mobile",
      }
      ..options.responseType = ResponseType.json;

    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
        requestBody: true,
      ),
    );
  }

  Future<Response?> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to format data");
    } catch (error) {
      debugPrint("HTTP exception ==============>");

      if (error is DioError) {
        if (error.response != null) {
          switch (error.response!.statusCode) {
            case 401:
              debugPrint(
                  "==============================> User token has expired and is no longer authenticated");
              return await DioConnectivityRetrier(
                dio: _dio,
                requestOptions: error.requestOptions,
                refreshToken: _refreshToken,
              ).requestRetrier();
            default:
              rethrow;
          }
        } else {
          rethrow;
        }
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      debugPrint("HTTP exception ==============>");
      if (error is DioError) {
        if (error.response != null) {
          switch (error.response!.statusCode) {
            case 401:
              debugPrint(
                  "==============================> User token has expired and is nolonger authenticated");
              return await DioConnectivityRetrier(
                dio: _dio,
                requestOptions: error.requestOptions,
                refreshToken: _refreshToken,
              ).requestRetrier();
            default:
              rethrow;
          }
        } else {
          rethrow;
        }
      } else {
        rethrow;
      }
    }
  }

  Future<Response> delete(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.delete(uri,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          data: data);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      if (error is DioError) {
        switch (error.response!.statusCode) {
          case 401:
            return await DioConnectivityRetrier(
              dio: _dio,
              requestOptions: error.requestOptions,
              refreshToken: _refreshToken,
            ).requestRetrier();
          default:
            rethrow;
        }
      } else {
        rethrow;
      }
    }
  }
}
