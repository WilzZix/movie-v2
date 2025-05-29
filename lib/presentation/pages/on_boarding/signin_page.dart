import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/firebase_auth/firebase_auth_bloc.dart';
import 'package:movie/core/utils/components/button.dart';
import 'package:movie/core/utils/components/inputs/input_fields.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';
import 'package:movie/presentation/pages/bottom_navigation/bottom_navigation.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static String tag = 'sign-in';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controllerEmail.addListener(() {});
    controllerPassword.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FirebaseAuthBloc, FirebaseAuthState>(
        listener: (context, state) {
          if (state is UserLoggedInWithEmailAndPassword) {
            context.go(BottomNavigationPage.tag);
          }
          if (state is UserLoginError) {
            log('Error ${state.exception.message}');
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
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
                    hintText: 'Password',
                    focusNode: focusNodePassword,
                    controller: controllerPassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Buttons.primary(
                    text: 'Sign in',
                    onTap: () {
                      final isValid = _formKey.currentState?.validate() ?? false;
                      if (isValid) {
                        BlocProvider.of<FirebaseAuthBloc>(context).add(
                          LoginWithEmailAndPassword(
                            email: controllerEmail.text,
                            password: controllerPassword.text,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
