import 'package:flutter/material.dart';
import 'package:movie/core/utils/components/inputs/input_fields.dart';
import 'package:movie/core/utils/icons/icons.dart';

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
      backgroundColor: Colors.white,
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
                focusNode: focusNodePlaceholder,
                controller: controllerPlaceholder,
              ),
              const SizedBox(
                height: 8,
              ),
              InputField.username(
                hintText: 'Username',
                prefixIcon: AppIcons.icInputFieldPerson,
                focusNode: focusNodeUsername,
                controller: controllerUsername,
              ),
              const SizedBox(
                height: 8,
              ),
              InputField.email(
                hintText: 'email',
                prefixIcon: AppIcons.icInputFieldEmail,
                focusNode: focusNodeEmail,
                controller: controllerEmail,
              ),
              const SizedBox(
                height: 8,
              ),
              InputField.password(
                hintText: 'Password',
                suffixIcon: AppIcons.icInputFieldCloseEye,
                prefixIcon: AppIcons.icInputFieldPassword,
                focusNode: focusNodePassword,
                controller: controllerPassword,
              ),
              const SizedBox(
                height: 8,
              ),
              InputField.phone(
                hintText: 'Placeholder',
                prefixIcon: AppIcons.icInputFieldPerson,
                suffixIcon: AppIcons.icInputFieldArrowDown,
                focusNode: focusNodePhone,
                controller: controllerPhone,
              ),
              const SizedBox(
                height: 8,
              ),
              InputField.normal(
                hintText: '+1 000 000 000',
                prefixIcon: const Row(
                  children: [
                    Icon(Icons.flag),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
                focusNode: focusNodeDef,
                controller: controllerDef,
              ),
              const SizedBox(
                height: 8,
              ),
              InputField.code(
                focusNode: focusNodeCode,
                controller: controllerCode,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
