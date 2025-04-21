import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

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
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: MainPrimaryColor.primary500,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 24 + MediaQuery.of(context).padding.top,
                ),
                AppIcons.icAppIcon,
                const SizedBox(height: 32),
                Text(
                  'Unlimited Movies, Anytime, Anywhere',
                  textAlign: TextAlign.center,
                  style: Typographies.heading2.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 32),
                Text(
                  'Enjoy a vast collection of movies and TV shows in high quality. Start streaming now!',
                  textAlign: TextAlign.center,
                  style: Typographies.bodyLargeMedium
                      .copyWith(color: GreyScale.grayScale200),
                ),
                const SizedBox(height: 32),
                Image.asset('assets/icons/im_onboarding.png'),
                const SizedBox(height: 32),
                Text('Pager'),
                const SizedBox(height: 32),

              ],
            ),
          )
        ],
      ),
    );
  }
}
