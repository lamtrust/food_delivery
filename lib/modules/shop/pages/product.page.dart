import 'package:flutter/material.dart';
import 'package:food_delivery/configs/theme.config.dart';
import 'package:food_delivery/modules/shop/models/product.model.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:food_delivery/utils/extensions/double.extension.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        body: Container(
          height: context.height,
          width: context.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.product.id,
                child: Container(
                  height: sy(200),
                  width: context.width,
                  color: const Color(0xFFE9EEFF),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: sy(10),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: sx(20),
                          ),
                          width: context.width,
                          alignment: Alignment.center,
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading.gif",
                            image: widget.product.images.first,
                            fit: BoxFit.cover,
                            placeholderFit: BoxFit.scaleDown,
                            height: sy(99),
                            width: context.width,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sy(10),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: sx(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: sy(10),
                                  ),
                                ),
                                Text(
                                  widget.product.price > 1000
                                      ? widget.product.price.money
                                          .compactSymbolOnLeft
                                      : widget.product.price.money.symbolOnLeft,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: sy(17),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "⭐" * widget.product.rating.ceil(),
                                  style: TextStyle(
                                    fontSize: sy(11),
                                  ),
                                ),
                                SizedBox(
                                  height: sy(5),
                                ),
                                Text(
                                  "(${widget.product.rating})",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: sy(10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sy(10),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: sy(10),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: sx(20),
                  ),
                  child: ListView(
                    children: [
                      Text(
                        "Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: sy(11),
                        ),
                      ),
                      SizedBox(
                        height: sy(5),
                      ),
                      Text(
                        widget.product.description,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: sy(9),
                        ),
                      ),
                      SizedBox(
                        height: sy(10),
                      ),
                      Text(
                        "Extras",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: sy(11),
                        ),
                      ),
                      SizedBox(
                        height: sy(5),
                      ),
                      Text(
                        "Unfortunately product has no extras",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: sy(9),
                        ),
                      ),
                      SizedBox(
                        height: sy(20),
                      ),
                      Consumer<ShopProvider>(builder: (context, provider, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quantity",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: sy(11),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.darkBlue,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.darkBlue,
                                  ),
                                ),
                                SizedBox(
                                  width: sx(15),
                                ),
                                Text(
                                  "${provider.getCartItemQuantity(widget.product)}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: sy(11),
                                  ),
                                ),
                                SizedBox(
                                  width: sx(15),
                                ),
                                Container(
                                  height: 35,
                                  width: 35,
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
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
