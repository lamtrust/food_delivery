import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/modules/auth/providers/login.provider.auth.dart';
import 'package:food_delivery/modules/auth/providers/register.provider.auth.dart';
import 'package:food_delivery/modules/shop/providers/navigation.provider.shop.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/modules/splash.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/utils/managers/dialog.manager.dart';
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
        ChangeNotifierProvider(
          create: (_) => ShopProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(),
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
    return MaterialApp(
      title: 'TN Grill',
      color: Colors.blueAccent,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Overpass",
      ),
      builder: (context, widget) => Navigator(
        onGenerateRoute: (route) => MaterialPageRoute(
          builder: (context) => DialogManager(child: widget!),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
