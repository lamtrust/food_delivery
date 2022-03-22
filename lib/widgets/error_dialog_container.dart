import 'package:flutter/material.dart';
import 'package:food_delivery/configs/colors.config.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:relative_scale/relative_scale.dart';

class ErrorDialogContainer extends StatelessWidget {
  const ErrorDialogContainer({
    Key? key,
    required this.title,
    required this.message,
    this.buttonText = "Okay",
    this.onButtonClick,
    this.isLogout = false,
  });

  final String title;
  final String message;
  final String? buttonText;
  final Function? onButtonClick;
  final bool? isLogout;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Container(
        width: context.width,
        // height: sy(210),
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: context.width,
                height: sy(70),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sy(17),
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(
                height: sy(15),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sx(20),
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // TODO: Fix Colors here
                    color: ColorConfigs.PRIMARY_COLOR,
                    fontSize: sy(10),
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(
                height: sy(15),
              ),
              GestureDetector(
                onTap: () {
                  if (onButtonClick != null) {
                    onButtonClick!();
                    // if (isLogout == true) {
                    //   context.routeTo(
                    //     page: LoginScreen(),
                    //     replace: true,
                    //   );
                    // }
                  } else {
                    context.goBack();
                  }
                },
                child: Container(
                  width: context.width,
                  height: 45,
                  margin: EdgeInsets.symmetric(
                    horizontal: sx(20),
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      // TODO: Fix Colors here
                      colors: [
                        ColorConfigs.PRIMARY_COLOR,
                        ColorConfigs.PRIMARY_COLOR,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(3, 1.5),
                      ),
                    ],
                  ),
                  child: Text(
                    buttonText ?? "Okay",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sy(11),
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sy(15),
              ),
            ],
          ),
        ),
      );
    });
  }
}
