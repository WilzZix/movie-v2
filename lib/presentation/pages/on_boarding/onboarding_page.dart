import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie/core/utils/colors.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  static String tag = '/';

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: MainPrimaryColor.primary500,
          )
        ],
      ),
    );
  }
}
