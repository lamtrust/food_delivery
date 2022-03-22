import 'package:flutter/material.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:relative_scale/relative_scale.dart';

class SuccessDialogContainer extends StatelessWidget {
  const SuccessDialogContainer({
    Key? key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Container(
        width: context.width,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: context.width,
                padding: EdgeInsets.symmetric(
                  vertical: sy(5),
                ),
                height: sy(70),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
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
                    // TODO: Fix colors here
                    color: context.theme.primaryColor,
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
                onTap: () => context.goBack(),
                child: Container(
                  width: context.width,
                  height: 45,
                  margin: EdgeInsets.symmetric(
                    horizontal: sx(20),
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      // TODO: Fix colors here
                      colors: [
                        context.theme.primaryColor,
                        context.theme.primaryColor,
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
                    'Okay',
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
