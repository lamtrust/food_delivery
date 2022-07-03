import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/configs/api.config.dart';
import 'package:food_delivery/modules/shop/models/cart_item.model.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';
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

  static Future<bool> checkout({
    required String access,
    required List<CartItem> cart,
    required int deliveryAddressId,
    required String paymentMethod,
  }) async {
    locator<DialogService>().showLoaderDialog(message: "Checking out...");
    Map<String, dynamic> cartData = {
      "payment_method": paymentMethod,
      "delivery_address_id": deliveryAddressId,
      "order_type": 1,
      "cart": cart.map((item) {
        return {
          "product_id": item.product.id,
          "quantity": item.quantity,
        };
      }).toList(),
    };

    debugPrint("FORM DATA MAP: $cartData");

    FormData data = FormData.fromMap(cartData);

    try {
      Dio dio = Dio()
        ..interceptors.add(
          LogInterceptor(
            responseBody: true,
            requestHeader: true,
            requestBody: true,
            request: true,
            error: true,
            responseHeader: true,
          ),
        );
      Response response = await dio.post(
        "${ApiConfig.BASE_URL}/customer/order/place",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $access",
          },
        ),
      );

      locator<DialogService>().dialogComplete();

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (error) {
      locator<DialogService>().dialogComplete();
      if (error is DioError) {
        handleDioErrors(error);
      }
      return false;
    }
  }
}
