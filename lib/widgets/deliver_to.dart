import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class DeliverTo extends StatelessWidget {
  const DeliverTo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Row(
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
            height: 50,
            width: 50,
          ),
        ],
      );
    });
  }
}
