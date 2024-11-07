import 'package:go_router/go_router.dart';
import 'package:movie/presentation/pages/home_page/home_page.dart';
import 'package:movie/presentation/pages/movie_detail_page/movie_detail_page.dart';
import 'package:movie/presentation/tablet/home_page.dart';

import '../../presentation/pages/favourite_page/favourite_page.dart';
import '../../presentation/pages/home_page/components/see_all_movies_page.dart';

class AppRouter {
  AppRouter();

  final router = GoRouter(
    initialLocation: '/',
    routes: [
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
          )
        ],
      ),
    ],
  );

  final tabletRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: TabletHomePage.tag,
        name: TabletHomePage.tag,
        builder: (_, __) => const TabletHomePage(),
      )
    ],
  );
}
