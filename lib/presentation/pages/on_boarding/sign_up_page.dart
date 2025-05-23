import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/button.dart';
import 'package:movie/core/utils/components/checkbox.dart';
import 'package:movie/core/utils/components/inputs/input_fields.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart' show Typographies;
import 'package:movie/presentation/pages/bottom_navigation/bottom_navigation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static String tag = '/sign-up';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FocusNode focusNodeDef = FocusNode();
  FocusNode focusNodeUsername = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodePlaceholder = FocusNode();
  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodeCode = FocusNode();
  TextEditingController controllerDef = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPlaceholder = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              AppIcons.icAppIcon,
              const SizedBox(height: 32),
              Text(
                'Login to Your Account',
                textAlign: TextAlign.center,
                style: Typographies.heading2,
              ),
              const SizedBox(height: 100),
              InputField.email(
                hintText: 'email',
                focusNode: focusNodeEmail,
                controller: controllerEmail,
              ),
              const SizedBox(
                height: 20,
              ),
              InputField.password(
                hintText: 'Password',
                focusNode: focusNodePassword,
                controller: controllerPassword,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppCheckbox(),
                  const SizedBox(width: 8),
                  Text(
                    'Remember me',
                    style: Typographies.bodyMediumSemiBold,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Buttons.primary(
                text: 'Sign up',
                onTap: () {
                  context.pushNamed(BottomNavigationPage.tag);
                },
              ),
              const SizedBox(height: 37),
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
                    const Text('or continue with'),
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
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 87,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: GreyScale.grayScale200,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, bottom: 18, right: 32, left: 32),
                      child: AppIcons.icGoogle,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 60,
                    width: 87,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: GreyScale.grayScale200,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, bottom: 18, right: 32, left: 32),
                      child: AppIcons.icApple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 37),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: Typographies.bodyMediumRegular
                        .copyWith(color: GreyScale.grayScale500),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Sign in',
                      style: Typographies.bodyMediumSemiBold
                          .copyWith(color: MainPrimaryColor.primary500),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}
