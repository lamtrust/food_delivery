import 'package:flutter/material.dart';
import 'package:food_delivery/configs/theme.config.dart';
import 'package:food_delivery/modules/auth/pages/login.page.auth.dart';
import 'package:food_delivery/modules/auth/pages/register.page.auth.dart';
import 'package:food_delivery/modules/shop/pages/add_address.dart';
import 'package:food_delivery/modules/shop/pages/manage_addresses.dart';
import 'package:food_delivery/modules/shop/pages/manage_orders.page.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/services/dialog.service.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:provider/provider.dart';
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
      return Consumer<ShopProvider>(builder: (context, state, _) {
        return state.authenticated
            ? const Authenticated()
            : const Unauthenticated();
      });
    });
  }
}

class Authenticated extends StatelessWidget {
  const Authenticated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Consumer<ShopProvider>(builder: (context, state, _) {
        return Container(
          height: context.height,
          width: context.width,
          child: Column(
            children: [
              SizedBox(
                height: sy(20),
              ),
              const SizedBox(
                height: 180,
                width: 180,
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
              SizedBox(
                height: sy(15),
              ),
              Text(
                "${state.profile?.name}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: sy(12),
                ),
              ),
              state.profile!.emailVerified
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.profile!.email,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                            fontSize: sy(10),
                          ),
                        ),
                        SizedBox(
                          width: sx(10),
                        ),
                        const Image(
                          image: AssetImage("assets/icons/emails.png"),
                          height: 20,
                          width: 20,
                        ),
                      ],
                    )
                  : Text(
                      state.profile!.email,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontSize: sy(10),
                      ),
                    ),
              SizedBox(
                height: sy(20),
              ),
              GestureDetector(
                onTap: () => context.routeTo(
                  page: const AddAddressPage(),
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
                    "Add Address",
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
                  page: const ManageAddressesPage(),
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
                    "Manage Addresses",
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
                  page: const ManageOrders(),
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
                    "Manage Orders",
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
                onTap: () => locator<DialogService>().showErrorDialog(
                  title: "Confirmation",
                  message: "Are you sure you want to logout?",
                  buttonText: "Logout",
                  onButtonClick: state.logout,
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
                    "Logout",
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
    });
  }
}

class Unauthenticated extends StatelessWidget {
  const Unauthenticated({
    Key? key,
  }) : super(key: key);

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
