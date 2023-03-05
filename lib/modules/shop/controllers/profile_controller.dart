import 'package:dio/dio.dart';
import 'package:food_delivery/configs/api.config.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/utils/functions/handle_dio_errors.dart';

class ProfileController {
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

  static Future<bool> saveAddress({
    required String name,
    required String phone,
    required String address,
    required String addressType,
    required double latitude,
    required double longitude,
    required String token,
  }) async {
    try {
      _dialogService.showLoaderDialog(message: "Saving your address ...");
      Response response = await _dio.post(
        "${ApiConfig.BASE_URL}/customer/address/add",
        data: {
          "contact_person_name": name,
          "contact_person_number": phone,
          "address": address,
          "longitude": longitude,
          "latitude": latitude,
          "address_type": addressType,
          "personal": 1,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _dialogService.dialogComplete();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      _dialogService.dialogComplete();
      if (error is DioError) {
        handleDioErrors(error);
      }
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>?> getAddresses({
    required String token,
  }) async {
    try {
      Response response = await _dio.get(
        "${ApiConfig.BASE_URL}/customer/address/list",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>>? data = response.data
            .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
            .toList();
        return data;
      } else {
        return null;
      }
    } catch (error) {
      if (error is DioError) {
        handleDioErrors(error);
      }
      return null;
    }
  }
}
