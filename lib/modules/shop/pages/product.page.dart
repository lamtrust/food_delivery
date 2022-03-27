import 'package:flutter/material.dart';
import 'package:food_delivery/modules/shop/models/product.model.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
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
            children: [
              Hero(
                tag: widget.product.id,
                child: Container(
                  height: sy(160),
                  width: context.width,
                  color: const Color(0xFFE9EEFF),
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
            ],
          ),
        ),
      );
    });
  }
}
