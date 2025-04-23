
import 'package:flutter/material.dart';
import 'package:movie/core/utils/components/inputs/input_fields.dart';

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
        // Image.asset(
        //   'assets/icons/garfild_icon.png',
        //   fit: BoxFit.fill,
        // ),
        // BackdropFilter(
        //   filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        //   child: const SizedBox(
        //     width: 200,
        //     height: 200,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 130 + MediaQuery.of(context).padding.top,
              ),
              // AppIcons.icAppIcon,
              // const SizedBox(height: 32),
              // Text(
              //   'Login to Your Account',
              //   textAlign: TextAlign.center,
              //   style: Typographies.heading2.copyWith(color: Colors.white),
              // ),
              // const SizedBox(height: 200),
              InputField(
                hintText: 'Placeholder',
              ),
              SizedBox(
                height: 8,
              ),
              InputField.username(
                hintText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
              SizedBox(
                height: 8,
              ),
              InputField.email(
                hintText: 'email',
                prefixIcon: Icon(Icons.email),
              ),
              SizedBox(
                height: 8,
              ),
              InputField.password(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.remove_red_eye_sharp),
              ),
              SizedBox(
                height: 8,
              ),
              InputField.phone(
                hintText: 'Placeholder',
                prefixIcon: Icon(Icons.person),
                suffixIcon: Icon(Icons.keyboard_arrow_down),
              ),
              SizedBox(
                height: 8,
              ),
              InputField.normal(
                hintText: '+1 000 000 000',
                prefixIcon: Row(
                  children: [
                    Icon(Icons.flag),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              InputField.code(),
            ],
          ),
        )
      ]),
    );
  }
}
