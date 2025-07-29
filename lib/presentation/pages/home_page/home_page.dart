import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/application/movies_blocs/see_all_movies/see_all_movies_bloc.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/tags.dart';
import 'package:movie/core/utils/helpfull_functions/helpfull_functions.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';
import 'package:movie/presentation/pages/movie_detail_page/movie_detail_page.dart';
import 'package:shimmer/shimmer.dart';

import 'components/see_all_movies_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                BlocBuilder<MoviesBloc, MoviesState>(
                  buildWhen: (context, state) {
                    return state is UpcomingMoviesLoadedState;
                  },
                  builder: (context, state) {
                    if (state is UpcomingMoviesLoadedState) {
                      return Column(
                        children: [
                          CarouselSlider(
                            items: state.data.results!.map(
                              (i) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    context.pushNamed(MovieDetailPage.tag,
                                        extra: i.id);
                                  },
                                  child: Container(
                                    height: 466,
                                    width: 428,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                          45,
                                        ),
                                        bottomRight: Radius.circular(
                                          45,
                                        ),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w1280${i.backdropPath ?? ''}',
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Spacer(),
                                        AppIcons.icPlayVideoIcon,
                                        const SizedBox(height: 16),
                                        Text(
                                          i.originalTitle!,
                                          style: Typographies.heading4.copyWith(
                                              color:
                                                  MainPrimaryColor.primary100),
                                        ),
                                        const SizedBox(height: 16),
                                        if (i.genreIds.isNotEmpty)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TagComponent(
                                                title: GenreIdTOStringName
                                                    .getGenreName(
                                                        i.genreIds.first),
                                              ),
                                              const SizedBox(width: 12),
                                              TagComponent(
                                                title: DateTime.parse(
                                                        i.releaseDate!)
                                                    .year
                                                    .toString(),
                                              ),
                                              const SizedBox(width: 12),
                                              TagComponent(
                                                title: i.originalLanguage!,
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 30),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                                height: 466,
                                autoPlay: true,
                                viewportFraction: 1),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              itemCount: state.data.results!.length,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    context.pushNamed(MovieDetailPage.tag,
                                        extra: state.data.results![index].id);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    height: 50,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w1280${state.data.results![index].backdropPath}',
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    }
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          Container(
                            height: 466,
                            width: 428,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                  45,
                                ),
                                bottomRight: Radius.circular(
                                  45,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                const Spacer(),
                                AppIcons.icPlayVideoIcon,
                                const SizedBox(height: 16),
                                Text(
                                  '',
                                  style: Typographies.heading4.copyWith(
                                      color: MainPrimaryColor.primary100),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    height: 50,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 24.0,
                    right: 24,
                    top: 24 + MediaQuery.of(context).padding.top,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [AppIcons.icAppIcon, AppIcons.icNotification],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top 10 Movies This Week',
                    style: Typographies.heading5,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(SeeAllMoviesPage.tag,
                          extra: SeeAllMoviesEntity('Top 10 Movies This Week',
                              MovieType.topMoviesPick));
                    },
                    child: Text(
                      'See all',
                      style: Typographies.bodyMediumSemiBold
                          .copyWith(color: MainPrimaryColor.primary500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            BlocBuilder<MoviesBloc, MoviesState>(
              buildWhen: (context, state) {
                return state is TopRatedMoviesLoadedState;
              },
              builder: (context, state) {
                if (state is TopRatedMoviesLoadedState) {
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: state.data.results!.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            context.pushNamed(MovieDetailPage.tag,
                                extra: state.data.results![index].id);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w1280${state.data.results![index].backdropPath}',
                                ),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 8),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IMDbTag(
                                      title: state
                                          .data.results![index].voteAverage!
                                          .toStringAsFixed(1),
                                    ),
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
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8.0, left: 8),
                            child: SizedBox(),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Movies',
                    style: Typographies.heading5,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(SeeAllMoviesPage.tag,
                          extra: SeeAllMoviesEntity(
                              'Popular Movies', MovieType.popular));
                    },
                    child: Text(
                      'See all',
                      style: Typographies.bodyMediumSemiBold
                          .copyWith(color: MainPrimaryColor.primary500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            BlocBuilder<MoviesBloc, MoviesState>(
              buildWhen: (context, state) {
                return state is PopularMoviesLoadedState;
              },
              builder: (context, state) {
                if (state is PopularMoviesLoadedState) {
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: state.data.results!.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            context.pushNamed(MovieDetailPage.tag,
                                extra: state.data.results![index].id);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w1280${state.data.results![index].backdropPath}',
                                ),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 8),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IMDbTag(
                                      title: state
                                          .data.results![index].voteAverage!
                                          .toStringAsFixed(1),
                                    ),
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
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8.0, left: 8),
                            child: SizedBox(),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Series',
                    style: Typographies.heading5,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(SeeAllMoviesPage.tag,
                          extra: SeeAllMoviesEntity(
                              'Popular Series', MovieType.tvShow));
                    },
                    child: Text(
                      'See all',
                      style: Typographies.bodyMediumSemiBold
                          .copyWith(color: MainPrimaryColor.primary500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            BlocBuilder<MoviesBloc, MoviesState>(
              buildWhen: (context, state) {
                return state is TrendingTVShowLoadedState;
              },
              builder: (context, state) {
                if (state is TrendingTVShowLoadedState) {
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: state.moviesResult.results!.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            context.pushNamed(MovieDetailPage.tag,
                                extra: state.moviesResult.results![index].id);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w1280${state.moviesResult.results![index].backdropPath}',
                                ),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 8),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IMDbTag(
                                      title: state.moviesResult.results![index]
                                          .voteAverage!
                                          .toStringAsFixed(1),
                                    ),
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
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8.0, left: 8),
                            child: SizedBox(),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
