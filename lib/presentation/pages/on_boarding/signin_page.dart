import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/firebase_auth/firebase_auth_bloc.dart';
import 'package:movie/core/utils/components/button.dart';
import 'package:movie/core/utils/components/checkbox.dart';
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
                Buttons.primary(
                  text: 'Sign in',
                  onTap: () {
                    BlocProvider.of<FirebaseAuthBloc>(context).add(
                        LoginWithEmailAndPassword(
                            email: controllerEmail.text,
                            password: controllerPassword.text));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
