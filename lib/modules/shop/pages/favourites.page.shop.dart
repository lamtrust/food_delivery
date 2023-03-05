import 'package:flutter/material.dart';
import 'package:food_delivery/modules/shop/models/product.model.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:food_delivery/widgets/product_container.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

import '../providers/shop.provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Container(
        height: context.height,
        width: context.width,
        padding: EdgeInsets.only(
          top: sy(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Favourites",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: sy(12),
              ),
            ),
            SizedBox(
              height: sy(10),
            ),
            Expanded(
              child: Consumer<ShopProvider>(builder: (context, provider, _) {
                return provider.favourites.isNotEmpty
                    ? GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.76,
                        crossAxisSpacing: sx(20),
                        mainAxisSpacing: sy(10),
                        children: provider.favourites.map((Product product) {
                          return ProductContainer(product: product);
                        }).toList(),
                      )
                    : Center(
                        child: Text(
                          "You don't have favourite products 😔😔",
                          style: TextStyle(
                            fontSize: sy(12),
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      );
              }),
            ),
            SizedBox(
              height: sy(5),
            ),
          ],
        ),
      );
    });
  }
}
