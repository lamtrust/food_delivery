import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/configs/theme.config.dart';
import 'package:food_delivery/modules/auth/pages/register.page.auth.dart';
import 'package:food_delivery/modules/auth/providers/login.provider.auth.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:localregex/localregex.dart';
import 'package:provider/provider.dart';
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
      return Scaffold(
        body: Container(
          height: context.height,
          width: context.width,
          padding: EdgeInsets.symmetric(
            horizontal: sx(20),
            vertical: sy(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sy(20),
              ),
              Text(
                "Let's Sign You In",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: sy(15),
                ),
              ),
              Text(
                "Welcome back, you've\nbeen missed",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                  fontSize: sy(10),
                ),
              ),
              SizedBox(
                height: sy(40),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child:
                      Consumer<LoginProvider>(builder: (context, provider, _) {
                    return Form(
                      key: provider.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email Address",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: sy(10),
                            ),
                          ),
                          SizedBox(
                            height: sy(5),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: sx(20),
                              vertical: sy(2),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9EEFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: provider.emailController,
                              decoration: InputDecoration(
                                hintText: "Email Address",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: sy(9),
                                ),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? email) {
                                if (email!.isEmpty) {
                                  return "Email Address is required!";
                                }

                                if (!LocalRegex.isEmail(email)) {
                                  return "Email Address is not valid!";
                                }

                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: sy(20),
                          ),
                          Text(
                            "Password",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: sy(10),
                            ),
                          ),
                          SizedBox(
                            height: sy(5),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: sx(20),
                              vertical: sy(2),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9EEFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: provider.passwordController,
                              decoration: InputDecoration(
                                hintText: "********",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: sy(9),
                                ),
                                border: InputBorder.none,
                                suffixIcon: InkWell(
                                  onTap: () => provider.togglePassword =
                                      !provider.showPassword,
                                  child: provider.showPassword
                                      ? const Icon(CupertinoIcons.eye_slash)
                                      : const Icon(CupertinoIcons.eye),
                                ),
                              ),
                              obscureText: !provider.showPassword,
                              keyboardType: TextInputType.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? password) {
                                if (password!.isEmpty) {
                                  return "Password is required!";
                                }

                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: sy(30),
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.login(context);
                            },
                            child: Container(
                              width: context.width,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: sx(20),
                                vertical: sy(12),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.darkBlue,
                                borderRadius: BorderRadius.circular(10),
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
                          SizedBox(
                            height: sy(10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: sy(10),
                                ),
                              ),
                              InkWell(
                                onTap: () => context.routeTo(
                                  page: const RegisterPage(),
                                ),
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: AppColors.gold,
                                    fontWeight: FontWeight.w900,
                                    fontSize: sy(10),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
