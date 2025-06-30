import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/presentation/pages/bottom_navigation/bottom_navigation.dart';
import 'package:movie/presentation/pages/home_page/components/video_player_page.dart';
import 'package:movie/presentation/pages/movie_detail_page/movie_detail_page.dart';
import 'package:movie/presentation/pages/movie_detail_page/person_page.dart';
import 'package:movie/presentation/pages/on_boarding/onboarding_page.dart';
import 'package:movie/presentation/pages/on_boarding/sign_up_page.dart'
    show SignUpPage;
import 'package:movie/presentation/pages/on_boarding/signin_page.dart';
import 'package:movie/presentation/pages/settings_page/edit_profile.dart';
import 'package:movie/presentation/pages/settings_page/payment_page.dart';
import 'package:movie/presentation/pages/settings_page/subscribe_now_page.dart';

import '../../presentation/pages/favourite_page/favourite_page.dart';
import '../../presentation/pages/home_page/components/see_all_movies_page.dart';
import '../../presentation/pages/on_boarding/login_and_registration_page.dart';

class AppRouter {
  AppRouter();

  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: OnBoardingPage.tag,
        builder: (_, __) => const OnBoardingPage(),
        routes: [
          GoRoute(
            path: LoginAndRegistrationPage.tag,
            name: LoginAndRegistrationPage.tag,
            builder: (context, state) {
              return const LoginAndRegistrationPage();
            },
            routes: [
              GoRoute(
                path: SignUpPage.tag,
                name: SignUpPage.tag,
                builder: (context, state) {
                  return const SignUpPage();
                },
              )
            ],
          ),
          GoRoute(
              path: SignInPage.tag,
              name: SignInPage.tag,
              builder: (_, __) => const SignInPage())
        ],
      ),
      GoRoute(
        name: BottomNavigationPage.tag,
        path: BottomNavigationPage.tag,
        builder: (context, state) => const BottomNavigationPage(),
        routes: [
          GoRoute(
            path: MovieDetailPage.tag,
            name: MovieDetailPage.tag,
            builder: (_, state) => MovieDetailPage(
              movieId: state.extra as int,
            ),
            routes: [
              GoRoute(
                path: PersonPage.tag,
                name: PersonPage.tag,
                builder: (_, state) => PersonPage(
                  personId: state.extra as int,
                ),
              )
            ],
          ),
          GoRoute(
            path: WatchList.tag,
            name: WatchList.tag,
            builder: (_, __) {
              return const WatchList();
            },
          ),
          GoRoute(
            path: SeeAllMoviesPage.tag,
            name: SeeAllMoviesPage.tag,
            builder: (_, state) => SeeAllMoviesPage(
              seeAllMoviesEntity: state.extra as SeeAllMoviesEntity,
            ),
          ),
          GoRoute(
            path: VideoPlayerPage.tag,
            name: VideoPlayerPage.tag,
            builder: (_, state) => VideoPlayerPage(
              videoId: state.extra as String,
            ),
          )
        ],
      ),
      GoRoute(
          path: SubscribeNowPage.tag,
          name: SubscribeNowPage.tag,
          builder: (_, __) => const SubscribeNowPage(),
          routes: [
            GoRoute(
                path: PaymentPage.tag,
                name: PaymentPage.tag,
                builder: (_, __) => const PaymentPage())
          ]),
      GoRoute(
          path: EditProfile.tag,
          name: EditProfile.tag,
          builder: (_, __) => const EditProfile())
    ],
  );
}
