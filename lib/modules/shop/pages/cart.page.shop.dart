import 'package:flutter/material.dart';
import 'package:food_delivery/configs/theme.config.dart';
import 'package:food_delivery/modules/shop/models/cart_item.model.dart';
import 'package:food_delivery/modules/shop/pages/checkout.page.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:food_delivery/utils/extensions/double.extension.dart';
import 'package:food_delivery/widgets/cart_item_container.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../widgets/currency_switch.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: context.height,
          width: context.width,
          padding: EdgeInsets.only(
            top: sy(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Cart",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: sy(12),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "USD PRICES",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: sy(9),
                        ),
                      ),
                      SizedBox(
                        width: sx(10),
                      ),
                      const CurrencySwitch(),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: sy(10),
              ),
              Expanded(
                child: Consumer<ShopProvider>(
                  builder: (context, provider, _) {
                    return provider.cartCount > 0
                        ? ListView(
                            shrinkWrap: true,
                            children: provider.cart.map((CartItem item) {
                              return CartItemContainer(
                                item: item,
                              );
                            }).toList(),
                          )
                        : Center(
                            child: Text(
                              "Your cart is empty 😔😔",
                              style: TextStyle(
                                fontSize: sy(12),
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                          );
                  },
                ),
              ),
              Consumer<ShopProvider>(builder: (context, provider, _) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EEFF),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: sx(20),
                          vertical: sy(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: sy(12),
                                  ),
                                ),
                                Text(
                                  (provider.isUsd
                                          ? provider.cartTotal
                                          : provider.cartTotal.rtgsAmount)
                                      .money
                                      .symbolOnLeft,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: sy(12),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: sy(7),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: sy(12),
                                  ),
                                ),
                                Text(
                                  (provider.isUsd
                                          ? provider.cartTotal
                                          : provider.cartTotal.rtgsAmount)
                                      .money
                                      .symbolOnLeft,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: sy(12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (provider.authenticated) {
                            context.routeTo(
                              page: const CheckoutPage(),
                            );
                          } else {
                            context.notification(
                              message:
                                  "Login to proceed. The application needs your delivery details!",
                              isError: true,
                            );
                          }
                        },
                        child: Container(
                          width: context.width,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            vertical: sy(10),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.darkBlue,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: sy(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: sy(10),
              ),
            ],
          ),
        );
      },
    );
  }
}
