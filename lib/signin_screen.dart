import 'package:first_flutter/common/primary_button.dart';
import 'package:first_flutter/common/text_field.dart';
import 'package:first_flutter/home_screen.dart';
import 'package:flutter/material.dart';

import 'common/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'common/social_buttons.dart';
import 'home_color.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var isSignIn = true;
  var pageTitle = "Sign in";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SvgPicture.asset('assets/images/x.svg', width: 24, height: 24),
        ),
        backgroundColor: AppColors.darkBackground,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            spacing: 40,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.overlay50,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: 46,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            setState(() {
                              isSignIn = true;
                              pageTitle = "Sign in";
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              isSignIn
                                  ? AppColors.darkBackground
                                  : AppColors.overlay50,
                            ),
                          ),
                          child: const Text("Sign in"),
                        ),
                      ),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            setState(() {
                              isSignIn = false;
                              pageTitle = "Sign up";
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              !isSignIn
                                  ? AppColors.darkBackground
                                  : AppColors.overlay50,
                            ),
                          ),
                          child: Text("Sign Up"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  pageTitle,
                  style: TextStyle(color: AppColors.white, fontSize: 40),
                ),
              ),
              Column(
                spacing: 12,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Color(0xFFA7AFB7),
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        isSignIn
                            ? "Sign in with mobile"
                            : "Register with mobile",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  CommonTextField(hintText: "Enter Your Email"),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Color(0xFFA7AFB7),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  CommonTextField(hintText: "Enter Your Password"),
                  Text(
                    isSignIn ? "Forgot password?" : "",
                    style: TextStyle(color: AppColors.primary, fontSize: 18),
                  ),
                ],
              ),
              Column(
                spacing: 20,
                children: [
                  PrimaryButton(onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeColor()),
                    );
                  }, buttonText: isSignIn? "Sign in": "Sign up"),
                  Text(
                    "Or login with",
                    style: TextStyle(color: AppColors.grey, fontSize: 16),
                  ),
                  Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: SocialLoginButton(
                          onPressed: () {},
                          text: 'Facebook',
                          iconPath: 'assets/images/facebook.png',
                        ),
                      ),
                      Expanded(
                        child: SocialLoginButton(
                          onPressed: () {},
                          text: 'Google',
                          iconPath: 'assets/images/google.png',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
