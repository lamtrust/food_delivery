import 'package:flutter/material.dart';
import 'package:food_delivery/configs/theme.config.dart';
import 'package:food_delivery/modules/shop/models/cart_item.model.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/utils/extensions/double.extension.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class CartItemContainer extends StatelessWidget {
  const CartItemContainer({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: sx(20),
          vertical: sy(5),
        ),
        margin: EdgeInsets.only(
          bottom: sy(10),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFE9EEFF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.gif",
              image: item.product.image,
              height: sy(40),
              width: sx(100),
            ),
            SizedBox(
              width: sx(10),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: sy(12),
                    ),
                  ),
                  Text(
                    item.product.description,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: sy(8),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: sy(20),
            ),
            Consumer<ShopProvider>(builder: (context, provider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => provider.decrementCartItemCount(item),
                        child: Container(
                          height: 25,
                          width: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.darkBlue,
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: AppColors.darkBlue,
                            size: sy(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: sx(15),
                      ),
                      Text(
                        "${item.quantity}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: sy(10),
                        ),
                      ),
                      SizedBox(
                        width: sx(15),
                      ),
                      InkWell(
                        onTap: () => provider.incrementCartItemQuantity(item),
                        child: Container(
                          height: 25,
                          width: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.darkBlue,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: sy(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sy(5),
                  ),
                  Text(
                    item.product.price > 1000
                        ? item.product.price.money.compactSymbolOnLeft
                        : item.product.price.money.symbolOnLeft,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: sy(11),
                    ),
                  ),
                ],
              );
            })
          ],
        ),
      );
    });
  }
}
