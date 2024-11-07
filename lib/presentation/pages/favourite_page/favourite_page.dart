import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/auth/auth_bloc.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/presentation/pages/movie_detail_page/movie_detail_page.dart';

import '../home_page/components/movie_list_item.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouriteState();
}

class _FavouriteState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'My favourite movies',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is UserLoginStatus) {
            return state.loggedIn
                ? const MyWatchlistWidget()
                : Center(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        shape: BoxShape.rectangle,
                        color: Colors.blue,
                      ),
                      child: const Center(
                        child: Text(
                          'Sign in with TMDB for see your movies',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class MyWatchlistWidget extends StatefulWidget {
  const MyWatchlistWidget({super.key});

  @override
  State<MyWatchlistWidget> createState() => _MyWatchlistWidgetState();
}

class _MyWatchlistWidgetState extends State<MyWatchlistWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          context.pushNamed(WatchList.tag);
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.tabletCardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'My watchlist',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WatchList extends StatefulWidget {
  const WatchList({super.key});

  static String tag = 'watch-list';

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(GetWatchListMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Watchlist',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        buildWhen: (context, state) {
          return state is WatchListMoviesLoadedState ||
              state is WatchListMoviesLoadedErrorState;
        },
        builder: (context, state) {
          if (state is WatchListMoviesLoadingState) {
            return const CircularProgressIndicator();
          }
          if (state is WatchListMoviesLoadedErrorState) {
            return Center(
              child: Text(
                state.msg,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            );
          }
          if (state is WatchListMoviesLoadedState) {
            return SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: state.data.results!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
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
      ),
    );
  }
}
