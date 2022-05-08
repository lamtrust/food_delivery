import 'package:dio/dio.dart';
import 'package:food_delivery/configs/api.config.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/utils/functions/handle_dio_errors.dart';

class AuthController {
  static final Dio _dio = Dio()
    ..httpClientAdapter
    ..options.headers = {
      Headers.contentTypeHeader: "application/json",
    }
    ..options.responseType = ResponseType.json
    ..interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true,
        requestBody: true,
      ),
    );

  static final DialogService _dialogService = locator<DialogService>();

  static Future<String?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      _dialogService.showLoaderDialog(
          message: "Creating Your Account. Hold on ...");
      Response response =
          await _dio.post("${ApiConfig.BASE_URL}/auth/register", data: {
        "firstname": firstName,
        "lastname": lastName,
        "phone": phone,
        "email": email,
        "password": password,
      });

      _dialogService.dialogComplete();

      if (response.statusCode == 200) {
        String token = response.data['token'];
        return token;
      } else {
        return null;
      }
    } catch (error) {
      _dialogService.dialogComplete();
      if (error is DioError) {
        handleDioErrors(error);
      }
      return null;
    }
  }

  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      _dialogService.showLoaderDialog(message: "Authenticating...");
      Response response = await _dio.post(
        "${ApiConfig.BASE_URL}/auth/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      _dialogService.dialogComplete();

      if (response.statusCode == 200) {
        String token = response.data['user_access'];
        return token;
      } else {
        return null;
      }
    } catch (error) {
      _dialogService.dialogComplete();
      if (error is DioError) {
        handleDioErrors(error);
      }
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getAuthenticatedProfile({
    required String token,
  }) async {
    try {
      _dialogService.showLoaderDialog(message: "Fetching profile...");
      Response response = await _dio.get(
        "${ApiConfig.BASE_URL}/customer/profile",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _dialogService.dialogComplete();

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (error) {
      _dialogService.dialogComplete();
      if (error is DioError) {
        handleDioErrors(error);
      }
      return null;
    }
  }
}
