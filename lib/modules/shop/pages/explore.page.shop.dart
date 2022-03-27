import 'package:flutter/material.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:food_delivery/widgets/deliver_to.dart';
import 'package:relative_scale/relative_scale.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
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
