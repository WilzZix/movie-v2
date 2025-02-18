import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/presentation/pages/home_page/home_page.dart';

import '../favourite_page/favourite_page.dart';
import '../search_page/search_page.dart';
import '../settings_page/settings_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
  });

  static String tag = '/';

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(GetUpcomingMoviesEvent(1));
    BlocProvider.of<MoviesBloc>(context).add(GetPopularMoviesEvent(1));
  }

  List<Widget> screens = [
    const HomePage(),
    const SearchPage(),
    const FavouritePage(),
    const SettingsPage(),
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
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            activeIcon: AppIcons.icHomeIcon,
            icon: AppIcons.icHomeIconUnselected,
          ),
          BottomNavigationBarItem(
            activeIcon: AppIcons.icExploreIconUnselected,
            label: 'Explore',
            icon: AppIcons.icExploreIcon,
          ),
          BottomNavigationBarItem(
            label: 'Live TV',
            activeIcon: AppIcons.icLiveIconSelected,
            icon: AppIcons.icLiveIcon,
          ),
          BottomNavigationBarItem(
              label: 'My List',
              icon: AppIcons.icMyListIcon,
              activeIcon: AppIcons.icMyListIconSelected),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: AppIcons.icProfileIcon,
            activeIcon: AppIcons.icProfileIconSelected,
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedItem,
        children: screens,
      ),
    );
  }
}
