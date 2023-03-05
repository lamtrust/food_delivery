import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

extension ExtraContext on BuildContext {
  /// Height of device screen (y-axis)
  double get height => MediaQuery.of(this).size.height;

  /// Width of device screen (x-axis)
  double get width => MediaQuery.of(this).size.width;

  /// Get Theme
  ThemeData get theme => Theme.of(this);

  /// Navigate to new page
  routeTo({required Widget page, bool replace = false}) {
    return replace
        ? Navigator.of(this)
            .pushReplacement(MaterialPageRoute(builder: (context) => page))
        : Navigator.of(this)
            .push(MaterialPageRoute(builder: (context) => page));
  }

  /// Go Back
  ///
  /// Remove current screen from stack
  ///
  goBack({dynamic value}) {
    return Navigator.of(this).pop(value);
  }

  /// Go Back Clear
  ///
  /// Remove all screens from stack and push only one screen
  ///
  goBackClear({required Widget page}) {
    return Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  /// Show [SnackBar] for notifications
  notification({required String message, bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: RelativeBuilder(builder: (context, height, width, sy, sx) {
          return Container(
            height: sy(30),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const Image(
                    image: AssetImage("assets/images/logo.png"),
                    height: 35,
                    width: 35,
                  ),
                ),
                SizedBox(
                  width: sx(20),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notification",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: sy(10),
                        ),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: sy(8),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
        backgroundColor: isError
            ? Colors.red.withOpacity(0.95)
            // TODO: Find better color here
            : theme.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
