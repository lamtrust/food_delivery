import 'package:flutter/material.dart';
import 'package:food_delivery/configs/index.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
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
                    image: AssetImage("assets/images/chicken.png"),
                    height: sy(60),
                    width: sx(150),
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
