import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/application/movies_blocs/recommended_movies/recommended_movies_cubit.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/tags.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/presentation/pages/movie_detail_page/movie_detail_page.dart';

import 'components/search_bar_component.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool donotScroll = false;
  List<Result>? results = [];

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(searchMovie);
    scrollController.addListener(_loadMore);
    BlocProvider.of<MoviesBloc>(context).add(GetPreviousSearchResult());
  }

  void searchMovie() {
    donotScroll = false;
    if (controller.text.isNotEmpty) {
      BlocProvider.of<MoviesBloc>(context)
          .add(SearchMovieEvent(keyword: controller.text));
    } else {
      BlocProvider.of<MoviesBloc>(context).add(GetPreviousSearchResult());
    }
    setState(() {});
  }

  void cleanSearch() {
    controller.clear();
    BlocProvider.of<MoviesBloc>(context).add(GetPreviousSearchResult());
  }

  void _loadMore() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !donotScroll) {
      BlocProvider.of<MoviesBloc>(context).add(LoadMoreEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RecommendedMoviesCubit()..getRecommendedMovies(movieId: 238),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: SearchBarComponent(controller: controller),
          actions: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [],
                        ),
                      );
                    });
              },
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFedf3ff),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: AppIcons.icFilter),
              ),
            ),
            const SizedBox(width: 20)
          ],
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          buildWhen: (context, state) {
            return state is SearchMovieLoadedState;
          },
          builder: (context, state) {
            if (state is SearchMovieLoadedState) {
              results!.addAll(state.data.results!);
              return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                itemCount: results!.length,
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      context.pushNamed(MovieDetailPage.tag,
                          extra: results![index].id);
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 190,
                          height: 248,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w1280${results![index].backdropPath!}'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: IMDbTag(
                              title: results![index]
                                  .voteAverage!
                                  .toStringAsFixed(1)),
                        )
                      ],
                    ),
                  );
                },
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Recommendation for You',
                      style: Typographies.heading5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<RecommendedMoviesCubit, RecommendedMoviesState>(
                      builder: (context, state) {
                    if (state is RecommendedVideosLoadedState) {
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.data.results!.length,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
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
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 8),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                    return CircularProgressIndicator(
                        color: MainPrimaryColor.primary500);
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
