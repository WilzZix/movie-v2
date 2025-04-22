import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart' show Typographies;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static String tag = '/sign-up';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
                'Login to Your Account',
                textAlign: TextAlign.center,
                style: Typographies.heading2.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 32),
            ],
          ),
        )
      ]),
    );
  }
}
