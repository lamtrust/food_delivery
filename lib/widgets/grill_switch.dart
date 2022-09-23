/*
    @Project: food_delivery
    @Date: 16, September, 2022
    @Author: Ngonidzashe Mangudya
 
    Copyright (c) 2022 ModestNerd
*/
import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../configs/theme.config.dart';

class GrillSwitch extends StatelessWidget {
  const GrillSwitch({
    Key? key,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  final VoidCallback? onTap;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: sx(80),
              height: sy(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    AppColors.darkBlue,
                    Colors.lightBlueAccent,
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: 0,
              bottom: 0,
              right: value ? 0 : sx(40),
              child: Container(
                height: sy(16),
                width: sy(16),
                margin: EdgeInsets.symmetric(
                  horizontal: sx(5),
                ),
                decoration: BoxDecoration(
                  color: value ? Colors.white : Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
