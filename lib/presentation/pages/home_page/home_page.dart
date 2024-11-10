import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/auth/auth_bloc.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/application/movies_blocs/see_all_movies/see_all_movies_bloc.dart';
import 'package:movie/application/sort_home_widgets/sort_home_widget_cubit.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/presentation/pages/favourite_page/favourite_page.dart';
import 'package:movie/presentation/pages/home_page/components/movie_list_item.dart';
import 'package:movie/presentation/pages/home_page/components/popular_movie_item.dart';
import 'package:movie/presentation/pages/home_page/components/see_all_movies_page.dart';
import 'package:movie/presentation/pages/movie_detail_page/movie_detail_page.dart';
import 'package:movie/presentation/pages/search_page/search_page.dart';
import 'package:movie/presentation/pages/settings_page/settings_page.dart';

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
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home_outlined,
              size: 35,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.search,
              size: 35,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.list,
              size: 35,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person,
              size: 35,
              color: Colors.white,
            ),
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> list = [
    const PopularMoviesWidget(),
    const TopMoviesPickWidget(),
    const UpcomingMoviesWidget(),
  ];
  List<String> sortedKeys = [];
  Map<String, Widget> defaultWidgetOrder = {
    'popular': const PopularMoviesWidget(),
    'top_movies_pick': const TopMoviesPickWidget(),
    'upcoming': const UpcomingMoviesWidget(),
  };

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SortHomeWidgetCubit>(context).defaultSortedHomeWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        actions: [
          Stack(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
              )
            ],
          )
        ],
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'John David.',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<SortHomeWidgetCubit, SortHomeWidgetState>(
        builder: (context, state) {
          if (state is DefaultSortedWidget) {
            sortedKeys = defaultWidgetOrder.keys.toList()
              ..sort((a, b) => state.sortedHomeWidgets[a]!
                  .compareTo(state.sortedHomeWidgets[b]!));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: sortedKeys.map((key) {
                  return defaultWidgetOrder[key]!;
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

/*[
                    const SizedBox(
                      height: 24,
                    ),
                    const PopularMoviesWidget(),
                    const SizedBox(
                      height: 16,
                    ),
                    SeeAllMoviesListWidget(
                      title: 'Top Movies Pick',
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    const TopMoviesPickWidget(),
                    const SizedBox(
                      height: 16,
                    ),
                    SeeAllMoviesListWidget(
                      title: 'Upcoming Movies',
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    const UpcomingMoviesWidget(),
                  ]*/
class PopularMoviesWidget extends StatelessWidget {
  const PopularMoviesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (context, state) {
        return state is PopularMoviesLoadedState;
      },
      builder: (context, state) {
        if (state is PopularMoviesLoadedState) {
          return CarouselSlider.builder(
            itemCount: state.data.results!.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(MovieDetailPage.tag,
                      extra: state.data.results![itemIndex].id);
                },
                child: PopularMovieItem(
                  movieResult: state.data.results![itemIndex],
                ),
              );
            },
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          );
        }
        if (state is PopularMoviesLoadingState) {
          return const CircularProgressIndicator();
        }
        if (state is PopularMoviesLoadErrorState) {
          return Center(
            child: Text(
              state.msg,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class TopMoviesPickWidget extends StatelessWidget {
  const TopMoviesPickWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (context, state) {
        return state is TopRatedMoviesLoadedState ||
            state is TopRatedMoviesLoadingErrorState;
      },
      builder: (context, state) {
        if (state is TopRatedMoviesLoadingState) {
          return const CircularProgressIndicator();
        }
        if (state is TopRatedMoviesLoadingErrorState) {
          return Center(
            child: Text(
              state.msg,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          );
        }
        if (state is TopRatedMoviesLoadedState) {
          return SizedBox(
            height: 270,
            child: ListView.builder(
              itemCount: state.data.results!.length + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (state.data.results!.length == index) {
                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        SeeAllMoviesPage.tag,
                        extra: SeeAllMoviesEntity(
                          'Top Movies Pick',
                          MovieType.topMoviesPick,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          height: 100,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.tabletBackground,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Показать все',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(MovieDetailPage.tag,
                        extra: state.data.results![index].id);
                  },
                  child: MovieListItem(
                    moviesResult: state.data.results![index],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class UpcomingMoviesWidget extends StatelessWidget {
  const UpcomingMoviesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (context, state) {
        return state is UpcomingMoviesLoadedState;
      },
      builder: (context, state) {
        if (state is UpcomingMoviesLoadingState) {
          return const CircularProgressIndicator();
        }
        if (state is UpcomingMoviesLoadedState) {
          return SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: state.data.results!.length + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (state.data.results!.length == index) {
                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        SeeAllMoviesPage.tag,
                        extra: SeeAllMoviesEntity(
                          'Upcoming Movies',
                          MovieType.upcoming,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          height: 100,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.tabletBackground,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Показать все',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(MovieDetailPage.tag,
                        extra: state.data.results![index].id);
                  },
                  child: MovieListItem(
                    moviesResult: state.data.results![index],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
