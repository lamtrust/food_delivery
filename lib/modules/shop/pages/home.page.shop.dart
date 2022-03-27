import 'package:flutter/material.dart';
import 'package:food_delivery/configs/index.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:food_delivery/widgets/category_icon.dart';
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Deliver to",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: sy(13),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: sy(12),
                          ),
                          SizedBox(
                            width: sx(5),
                          ),
                          Text(
                            "136 Blakeway Drive, Belvedere",
                            style: TextStyle(
                              fontSize: sy(9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: 'https://picsum.photos/250?image=9',
                    ),
                  ),
                  height: 60,
                  width: 60,
                ),
              ],
            ),
            SizedBox(
              height: sy(20),
            ),
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
                              "25%",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: sy(13),
                              ),
                            ),
                            SizedBox(
                              width: sx(10),
                            ),
                            Text(
                              "off",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: sy(10),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Fast Foods",
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
                          "Valid until 27 April",
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
                ),
                CategoryIcon(
                  categoryName: "Drink",
                ),
                CategoryIcon(
                  categoryName: "Burger",
                ),
                CategoryIcon(
                  categoryName: "Regular",
                ),
                CategoryIcon(
                  categoryName: "Chips",
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
              child: ListView(
                children: [
                  Row(
                    children: [
                      Container(
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
                            Container(
                              height: sy(90),
                              decoration: BoxDecoration(
                                color: Color(0xFFE9EEFF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // child: FadeInImage.assetNetwork(
                              //   placeholder: "assets/images/loading.gif",
                              //   image: image,
                              // ),
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
                                      "(4.3)",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Hunger Buster Meal"),
                                      Text("\$5.00"),
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
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
