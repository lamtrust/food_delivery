import 'package:flutter/material.dart';
import 'package:food_delivery/configs/theme.config.dart';
import 'package:food_delivery/modules/shop/models/cart_item.model.dart';
import 'package:food_delivery/modules/shop/models/payment_method.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:food_delivery/utils/extensions/double.extension.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  PaymentMethod _paymentMethod = PaymentMethod.COD;
  Map<String, dynamic>? _address;

  Future<List<Map<String, dynamic>>?>? _future;

  @override
  void initState() {
    _future = Provider.of<ShopProvider>(context, listen: false).getAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            "Checkout",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: sy(12),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Container(
          height: context.height,
          width: context.width,
          padding: EdgeInsets.symmetric(
            vertical: sy(10),
            horizontal: sx(20),
          ),
          child: Consumer<ShopProvider>(
            builder: (context, provider, _) {
              return FutureBuilder(
                future: _future,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
                  while (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Failed to load data. Reload page'),
                    );
                  }

                  List<Map<String, dynamic>>? data = snapshot.data;

                  debugPrint("Returned Data: $data");

                  if (data == null) {
                    return const Center(
                      child: Text(
                          'No addresses found. Please save an address first.'),
                    );
                  }

                  return Form(
                    child: ListView(
                      children: [
                        DropdownButtonFormField(
                          value: _paymentMethod,
                          items:
                              PaymentMethod.values.map((PaymentMethod method) {
                            return DropdownMenuItem(
                              value: method,
                              child: Text(
                                "${method.name} ${method.name == "COD" ? "(Cash On Delivery)" : "(Ecocash / OneMoney)"}",
                              ),
                            );
                          }).toList(),
                          onChanged: (PaymentMethod? value) {
                            _paymentMethod = value!;
                          },
                          decoration: InputDecoration(
                            hintText: "Payment Method",
                            hintStyle: TextStyle(
                              color: AppColors.darkBlue,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.darkBlue,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.darkBlue,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.darkBlue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sy(10),
                        ),
                        DropdownButtonFormField(
                          items: data.map((Map<String, dynamic> address) {
                            return DropdownMenuItem(
                              value: address,
                              child: Text(
                                "${data.indexOf(address) + 1}. ${address["address"]}",
                              ),
                            );
                          }).toList(),
                          onChanged: (Map<String, dynamic>? value) {
                            _address = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Select Delivery Address",
                            hintStyle: TextStyle(
                              color: AppColors.darkBlue,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.darkBlue,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.darkBlue,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.darkBlue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sy(10),
                        ),
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: sy(12),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          height: sy(10),
                          color: AppColors.darkBlue.withOpacity(0.5),
                        ),
                        Text(
                          "Total: ${provider.cartTotal.money.symbolOnLeft}",
                          style: TextStyle(
                            fontSize: sy(12),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: sy(10),
                        ),
                        ...provider.cart.map((CartItem item) {
                          return Text(
                            "${item.quantity} X ${item.product.name} @ ${item.product.price.money.symbolOnLeft}",
                            style: TextStyle(
                              fontSize: sy(10),
                              fontWeight: FontWeight.normal,
                            ),
                          );
                        }).toList(),
                        SizedBox(
                          height: sy(15),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_address != null) {
                              bool success = await provider.checkout(
                                  deliveryAddressId: _address!["id"],
                                  paymentMethod: _paymentMethod.name);
                              if (success) {
                                provider.clearCart();
                                if (mounted) {
                                  context.goBack();
                                }
                              }
                            } else {
                              context.notification(
                                message: "Select delivery address",
                                isError: true,
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              vertical: sy(10),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.darkBlue,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: sy(11),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    });
  }
}
