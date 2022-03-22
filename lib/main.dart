import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:food_delivery/configs/index.dart';
import 'package:food_delivery/modules/shop/providers/navigation.provider.shop.dart';
import 'package:food_delivery/modules/splash.dart';
import 'package:food_delivery/services/index.dart';
import 'package:provider/provider.dart';

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NavigationProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: 'TN Grill',
      material: (BuildContext context, PlatformTarget target) {
        return MaterialAppData(
          theme: appThemeData,
          title: 'TN Grill',
          color: Colors.blueAccent,
        );
      },
      cupertino: (BuildContext context, PlatformTarget target) {
        return CupertinoAppData(
          theme: cupertinoAppThemeData,
          title: 'TN Grill',
          color: Colors.blueAccent,
        );
      },
      home: const SplashScreen(),
    );
  }
}
