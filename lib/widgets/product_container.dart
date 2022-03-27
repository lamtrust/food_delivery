import 'package:flutter/material.dart';
import 'package:food_delivery/configs/theme.config.dart';
import 'package:food_delivery/modules/shop/models/product.model.dart';
import 'package:food_delivery/modules/shop/pages/product.page.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:food_delivery/utils/extensions/double.extension.dart';
import 'package:relative_scale/relative_scale.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return GestureDetector(
        onTap: () => context.routeTo(
          page: ProductPage(product: product),
        ),
        child: Container(
          width: sx(250),
          padding: EdgeInsets.symmetric(
            horizontal: sx(10),
            vertical: sy(5),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.0,
                spreadRadius: 1.0,
                offset: const Offset(
                  1.0,
                  1.0,
                ),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: product.id,
                child: Container(
                  height: sy(90),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EEFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: product.images.first,
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.cover,
                    height: sy(99),
                    width: context.width,
                  ),
                ),
              ),
              SizedBox(
                height: sy(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TN GRILL",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: sy(9),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⭐",
                        style: TextStyle(
                          fontSize: sy(7),
                        ),
                      ),
                      SizedBox(
                        width: sx(1),
                      ),
                      Text(
                        "(${product.rating})",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: sy(9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: sy(5),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: sy(10),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          product.price > 1000
                              ? product.price.money.compactSymbolOnLeft
                              : product.price.money.symbolOnLeft,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: sy(11),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: sx(10),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.darkBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
