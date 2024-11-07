import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/presentation/tablet/components/upcoming_movies.dart';

class TopMoviesPick extends StatelessWidget {
  const TopMoviesPick({
    super.key,
    required this.size,
    required this.controller,
  });

  final Size size;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TopMoviesPickCard(size: size, controller: controller);
  }
}

class TopMoviesPickCard extends StatelessWidget {
  const TopMoviesPickCard({
    super.key,
    required this.size,
    required this.controller,
  });

  final Size size;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 4,
      color: AppColors.tabletBackground,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                label: Icon(Icons.search),
                hintText: 'Search Movies',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.tabletCardColor,
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text('Top Movies Pick'),
                    ],
                  ),
                  BlocBuilder<MoviesBloc, MoviesState>(
                    buildWhen: (context, state) {
                      return state is TopRatedMoviesLoadedState;
                    },
                    builder: (context, state) {
                      if (state is TopRatedMoviesLoadedState) {
                        return SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: state.data.results!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w1280${state.data.results![index].backdropPath}')),
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppColors.tabletCardColor,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            state.data.results![index]
                                                .originalTitle!,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            Icons.play_circle,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const UpcomingMovies(),
          ],
        ),
      ),
    );
  }
}
