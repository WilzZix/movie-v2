import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

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
          Column(
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
            ],
          )
        ],
      ),
    );
  }
}
