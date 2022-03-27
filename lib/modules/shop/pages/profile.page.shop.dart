import 'package:flutter/material.dart';
import 'package:food_delivery/configs/theme.config.dart';
import 'package:food_delivery/modules/auth/pages/login.page.auth.dart';
import 'package:food_delivery/modules/auth/pages/register.page.auth.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:relative_scale/relative_scale.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return SizedBox(
        height: context.height,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage("assets/images/logo.png"),
              height: sy(90),
            ),
            SizedBox(
              height: sy(60),
            ),
            GestureDetector(
              onTap: () => context.routeTo(
                page: const RegisterPage(),
              ),
              child: Container(
                width: context.width,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  vertical: sy(12),
                ),
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: sy(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: sy(20),
            ),
            GestureDetector(
              onTap: () => context.routeTo(
                page: const LoginPage(),
              ),
              child: Container(
                width: context.width,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  vertical: sy(12),
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkBlue,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: sy(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
