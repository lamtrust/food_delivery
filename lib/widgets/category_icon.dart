import 'package:flutter/material.dart';
import 'package:food_delivery/configs/theme.config.dart';
import 'package:food_delivery/utils/extensions/string.extension.dart';
import 'package:relative_scale/relative_scale.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    Key? key,
    required this.categoryName,
    required this.path,
  }) : super(key: key);

  final String categoryName;
  final String path;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
                width: 1.5,
              ),
              shape: BoxShape.circle,
            ),
            child: Transform.scale(
              scale: 0.6,
              child: Image(
                image: AssetImage(path),
                color: AppColors.darkBlue,
                height: sy(10),
              ),
            ),
          ),
          SizedBox(
            height: sy(5),
          ),
          Text(categoryName.titleCase),
        ],
      );
    });
  }
}
