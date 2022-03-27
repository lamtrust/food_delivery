import 'package:flutter/material.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:food_delivery/widgets/deliver_to.dart';
import 'package:relative_scale/relative_scale.dart';

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
          children: [
            const DeliverTo(),
          ],
        ),
      );
    });
  }
}
