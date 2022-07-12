import 'package:flutter/material.dart';
import 'package:food_delivery/configs/index.dart';
import 'package:food_delivery/modules/shop/models/product.model.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:food_delivery/widgets/category_icon.dart';
import 'package:food_delivery/widgets/product_container.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 1.0,
                    spreadRadius: 0.5,
                    offset: const Offset(
                      1.0,
                      1.0,
                    ),
                  )
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "What are you looking for?",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: sy(9),
                  ),
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: sy(20),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: sx(20),
                vertical: sy(10),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    AppColors.darkBlue,
                    Colors.lightBlueAccent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              "We're now open",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: sy(13),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "6.30am - 7pm",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: sy(10),
                          ),
                        ),
                        SizedBox(
                          height: sy(10),
                        ),
                        Text(
                          "Better deals at TN Grill",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: sy(10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image(
                    image: const AssetImage("assets/images/chicken.png"),
                    height: sy(60),
                    width: sx(150),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: sy(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: sy(10),
                  ),
                ),
                Text(
                  "view all",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                    fontSize: sy(10),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sy(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CategoryIcon(
                  categoryName: "Food",
                  path: "assets/icons/food.png",
                ),
                CategoryIcon(
                  categoryName: "Drink",
                  path: "assets/icons/drink.png",
                ),
                CategoryIcon(
                  categoryName: "Burger",
                  path: "assets/icons/burger.png",
                ),
                CategoryIcon(
                  categoryName: "Regular",
                  path: "assets/icons/meal.png",
                ),
                CategoryIcon(
                  categoryName: "Chips",
                  path: "assets/icons/chips.png",
                ),
              ],
            ),
            SizedBox(
              height: sy(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: sy(10),
                  ),
                ),
                Text(
                  "view all",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                    fontSize: sy(10),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sy(15),
            ),
            Expanded(
              child: Consumer<ShopProvider>(builder: (context, provider, _) {
                return FutureBuilder(
                  future: provider.getProducts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Product>> snapshot) {
                    while (
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    List<Product> products = snapshot.data!;

                    return GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.76,
                      crossAxisSpacing: sx(20),
                      mainAxisSpacing: sy(10),
                      children: products.map((Product product) {
                        return ProductContainer(product: product);
                      }).toList(),
                    );
                  },
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
