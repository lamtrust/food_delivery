import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:food_delivery/modules/splash.dart';
import 'package:food_delivery/services/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky)
      : null;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await setupServices();

  // runApp(
  //   MultiProvider(
  //     providers: [],
  //     child: const MyApp(),
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: 'TN Grill',
      material: (BuildContext context, PlatformTarget target) {
        return MaterialAppData(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          title: 'TN Grill',
          color: Colors.blueAccent,
        );
      },
      cupertino: (BuildContext context, PlatformTarget target) {
        return CupertinoAppData(
          theme: const CupertinoThemeData(
            primaryColor: Colors.blue,
          ),
          title: 'TN Grill',
          color: Colors.blueAccent,
        );
      },
      home: const SplashScreen(),
    );
  }
}
