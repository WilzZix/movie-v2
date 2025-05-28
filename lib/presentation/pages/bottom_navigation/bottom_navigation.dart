import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/application/movies_blocs/search_movie/search_movie_bloc.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/presentation/pages/home_page/home_page.dart';

import '../favourite_page/favourite_page.dart';
import '../search_page/search_page.dart';
import '../settings_page/settings_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
  });

  static String tag = '/bottom-navigation';

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(GetUpcomingMoviesEvent(1));
    BlocProvider.of<MoviesBloc>(context).add(GetPopularMoviesEvent(1));
    BlocProvider.of<MoviesBloc>(context).add(GetTrendingTVShowEvent(1));
    FlutterNativeSplash.remove();
  }

  List<Widget> screens = [
    const HomePage(),
    const SearchPage(),
    const FavouritePage(),
    const SettingsPage(),
  ];

  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          selectedItem = value;
          setState(() {});
        },
        currentIndex: selectedItem,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: AppIcons.icHomeIconUnselected,
            activeIcon: AppIcons.icHomeIcon,
          ),
          BottomNavigationBarItem(
            icon: AppIcons.icExploreIcon,
            activeIcon: AppIcons.icExploreIconUnselected,
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            label: 'My List',
            icon: AppIcons.icMyListIcon,
            activeIcon: AppIcons.icMyListIconSelected,
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: AppIcons.icProfileIcon,
            activeIcon: AppIcons.icProfileIconSelected,
          ),
        ],
      ),
      body: BlocProvider<SearchMovieBloc>(
        create: (context) => SearchMovieBloc(),
        child: IndexedStack(
          index: selectedItem,
          children: screens,
        ),
      ),
    );
  }
}
