import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/button.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';
import 'package:movie/presentation/pages/on_boarding/sign_up_page.dart';

class LoginAndRegistrationPage extends StatefulWidget {
  const LoginAndRegistrationPage({super.key});

  static String tag = '/login-and-registration';

  @override
  State<LoginAndRegistrationPage> createState() =>
      _LoginAndRegistrationPageState();
}

class _LoginAndRegistrationPageState extends State<LoginAndRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/icons/garfild_icon.png',
            fit: BoxFit.fill,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: const SizedBox(
              width: 200,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 130 + MediaQuery.of(context).padding.top,
                ),
                AppIcons.icAppIcon,
                const SizedBox(height: 32),
                Text(
                  'Start Streaming Now with Ava',
                  textAlign: TextAlign.center,
                  style: Typographies.heading2.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 60),
                const Buttons.social(type3: ButtonType3.google),
                const SizedBox(height: 16),
                const Buttons.social(type3: ButtonType3.apple),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Divider(
                          height: 1,
                          color: GreyScale.grayScale200,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text('or'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Divider(
                          height: 1,
                          color: GreyScale.grayScale200,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Buttons.primary(
                  text: 'Sign in',
                  onTap: () {},
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: Typographies.bodyMediumRegular
                          .copyWith(color: GreyScale.grayScale500),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(SignUpPage.tag);
                      },
                      child: Text(
                        'Sign up',
                        style: Typographies.bodyMediumSemiBold
                            .copyWith(color: MainPrimaryColor.primary500),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
