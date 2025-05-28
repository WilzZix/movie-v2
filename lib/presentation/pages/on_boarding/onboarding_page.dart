import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/firebase_auth/firebase_auth_bloc.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/button.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';
import 'package:movie/presentation/pages/bottom_navigation/bottom_navigation.dart';
import 'package:movie/presentation/pages/on_boarding/login_and_registration_page.dart';

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

  CarouselController carouselController = CarouselController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FirebaseAuthBloc, FirebaseAuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go(BottomNavigationPage.tag);
          } else if (state is Unauthenticated) {
            context.go(OnBoardingPage.tag);
          }
        },
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: MainPrimaryColor.primary500,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 24 + MediaQuery.of(context).padding.top,
                    ),
                    Text(
                      'Unlimited Movies, Anytime',
                      textAlign: TextAlign.center,
                      style:
                          Typographies.heading2.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Enjoy a vast collection of movies and TV shows in high quality. Start streaming now!',
                      textAlign: TextAlign.center,
                      style: Typographies.bodyLargeMedium
                          .copyWith(color: GreyScale.grayScale200),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 310,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        itemExtent: 400,
                        children: [
                          Image.asset('assets/icons/im_onboarding.png'),
                          Image.asset('assets/icons/im_onboarding2.png'),
                          Image.asset('assets/icons/im_onboarding3.png'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScrollPager(
                            isSelected: carouselController.initialItem ==
                                selectedIndex),
                        ScrollPager(
                            isSelected: carouselController.initialItem ==
                                selectedIndex),
                        ScrollPager(
                            isSelected: carouselController.initialItem ==
                                selectedIndex),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Buttons.primary(
                      text: 'Login & Registration',
                      onTap: () {
                        context.pushNamed(LoginAndRegistrationPage.tag);
                      },
                    ),
                    const SizedBox(height: 24),
                    const Buttons.secondary(text: 'Try as guest!'),
                    SizedBox(height: MediaQuery.of(context).padding.bottom)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ScrollPager extends StatefulWidget {
  const ScrollPager({super.key, required this.isSelected});

  final bool isSelected;

  @override
  State<ScrollPager> createState() => _ScrollPagerState();
}

class _ScrollPagerState extends State<ScrollPager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: widget.isSelected ? 32 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.isSelected
            ? MainPrimaryColor.primary500
            : GreyScale.grayScale500,
      ),
    );
  }
}
