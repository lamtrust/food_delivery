import 'package:dio/dio.dart';
import 'package:food_delivery/configs/api.config.dart';
import 'package:food_delivery/utils/functions/handle_dio_errors.dart';

class ProductsController {
  static Future<Map<String, dynamic>?> getProducts() async {
    try {
      Dio dio = Dio();
      Response response =
          await dio.get("${ApiConfig.BASE_URL}/products/latest");
      if (response.statusCode == 200) {
        return response.data;
      }

      return null;
    } catch (error) {
      if (error is DioError) {
        handleDioErrors(error);
      }
      return null;
    }
  }
}
