import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:relative_scale/relative_scale.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return PlatformScaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: context.height,
          width: context.width,
          padding: EdgeInsets.symmetric(
            horizontal: sx(20),
          ),
          // child: Column(
          //   children: [
          //     SizedBox(
          //       height: sy(40),
          //     ),
          //     Image(
          //       image: const AssetImage("assets/images/logo.png"),
          //       height: sy(60),
          //     ),
          //     SizedBox(
          //       height: sy(40),
          //     ),
          //     Text(
          //       "Welcome Back",
          //       style: TextStyle(
          //         color: Colors.black54,
          //         fontWeight: FontWeight.normal,
          //         fontSize: sy(15),
          //       ),
          //     ),
          //     SizedBox(
          //       height: sy(7),
          //     ),
          //     Text(
          //       "Sign In To Continue",
          //       style: TextStyle(
          //         color: Colors.black54,
          //         fontWeight: FontWeight.normal,
          //         fontSize: sy(10),
          //       ),
          //     ),
          //     SizedBox(
          //       height: sy(40),
          //     ),
          //     Expanded(
          //       child: Consumer<LoginProvider>(builder: (context, provider, _) {
          //         return Form(
          //           key: provider.formKey,
          //           child: ListView(
          //             children: [
          //               Container(
          //                 decoration: BoxDecoration(
          //                   border: Border.all(
          //                     color: Colors.black12,
          //                   ),
          //                   borderRadius: BorderRadius.circular(10),
          //                 ),
          //                 child: TextFormField(
          //                   controller: provider.emailController,
          //                   decoration: InputDecoration(
          //                     hintText: provider.emailHintText,
          //                     border: InputBorder.none,
          //                     prefixIcon: const Icon(CupertinoIcons.mail_solid),
          //                     suffixIcon: InkWell(
          //                       onTap: () {
          //                         provider.emailController.clear();
          //                       },
          //                       child: const Icon(
          //                         CupertinoIcons.clear_circled_solid,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: sy(10),
          //               ),
          //               Container(
          //                 decoration: BoxDecoration(
          //                   border: Border.all(
          //                     color: Colors.black12,
          //                   ),
          //                   borderRadius: BorderRadius.circular(10),
          //                 ),
          //                 child: TextFormField(
          //                   controller: provider.passwordController,
          //                   decoration: InputDecoration(
          //                     hintText: provider.passwordHintText,
          //                     border: InputBorder.none,
          //                     prefixIcon: const Icon(CupertinoIcons.padlock),
          //                     suffixIcon: InkWell(
          //                       onTap: () {
          //                         provider.togglePassword =
          //                             !provider.showPassword;
          //                       },
          //                       child: provider.showPassword
          //                           ? const Icon(CupertinoIcons.eye_slash_fill)
          //                           : const Icon(CupertinoIcons.eye_solid),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: sy(7),
          //               ),
          //               Container(
          //                 alignment: Alignment.bottomRight,
          //                 child: Text(
          //                   "Forgot Password?",
          //                   style: TextStyle(
          //                     color: Colors.black54,
          //                     fontWeight: FontWeight.normal,
          //                     fontSize: sy(10),
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: sy(20),
          //               ),
          //               GestureDetector(
          //                 onTap: () {},
          //                 child: Container(
          //                   width: context.width,
          //                   alignment: Alignment.center,
          //                   padding: EdgeInsets.symmetric(
          //                     vertical: sy(10),
          //                   ),
          //                   decoration: BoxDecoration(
          //                     color: ColorConfigs.PRIMARY_COLOR,
          //                     borderRadius: BorderRadius.circular(10),
          //                     boxShadow: [
          //                       BoxShadow(
          //                         color: Colors.grey.withOpacity(0.2),
          //                         spreadRadius: 1,
          //                         blurRadius: 4,
          //                         offset: const Offset(3, 1.5),
          //                       ),
          //                     ],
          //                   ),
          //                   child: Text(
          //                     "LOGIN",
          //                     style: TextStyle(
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: sy(10),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       }),
          //     ),
          //   ],
          // ),
        ),
      );
    });
  }
}
