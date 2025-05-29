import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/firebase_auth/firebase_auth_bloc.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FirebaseAuthBloc, FirebaseAuthState>(
        listener: (context, state) {
          if (state is UserRegisteredWithEmailAndPassword) {
            context.go(BottomNavigationPage.tag);
          }
          if (state is UserLoginError) {
            log('Error ${state.exception.message}');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }

                      // Simple email RegExp
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField.password(
                    hintText: 'Password',
                    focusNode: focusNodePassword,
                    controller: controllerPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'Must contain at least one uppercase letter';
                      }
                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                        return 'Must contain at least one lowercase letter';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Must contain at least one number';
                      }
                      if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                        return 'Must contain at least one special character (!@#\$&*~)';
                      }
                      return null;
                    },
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
                      final isValid =
                          _formKey.currentState?.validate() ?? false;
                      if (isValid) {
                        BlocProvider.of<FirebaseAuthBloc>(context).add(
                            RegisterWithEmailAndPassword(
                                email: controllerEmail.text,
                                password: controllerPassword.text));
                      }
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
        ),
      ),
    );
  }
}
