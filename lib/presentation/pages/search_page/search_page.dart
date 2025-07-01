import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/movies_blocs/recommended_movies/recommended_movies_cubit.dart';
import 'package:movie/application/movies_blocs/search_movie/search_movie_bloc.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/button.dart';
import 'package:movie/core/utils/components/tags.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/presentation/pages/movie_detail_page/movie_detail_page.dart';
import 'package:movie/presentation/pages/search_page/search_arguments.dart';

import 'components/media_type_widget.dart';
import 'components/search_bar_component.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Result>? results = [];
  MediaType mediaType = MediaType.all;

  @override
  void dispose() {
    scrollController.dispose();
    controller.dispose();
    WidgetsBinding.instance.removeObserver;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(searchMovie);
      scrollController.addListener(_loadMore);
    });
    context.read<RecommendedMoviesCubit>().getRecommendedMovies(movieId: 238);
  }

  void searchMovie() {
    if (controller.text.isNotEmpty) {
      BlocProvider.of<SearchMovieBloc>(context).add(SearchEventInitial(
          keyword: controller.text,
          arguments: SearchArguments(mediaType: mediaType)));
    } else {}
    setState(() {});
  }

  void cleanSearch() {
    controller.clear();
  }

  void _loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<SearchMovieBloc>(context).add(LoadMoreEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBarComponent(controller: controller),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                showDragHandle: true,
                backgroundColor: Colors.white,
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                    value: context.read<SearchMovieBloc>(),
                    child: StatefulBuilder(builder: (context, modalSheetState) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          mediaType = MediaType.values[0];
                                          modalSheetState(() {});
                                        },
                                        child: MediaTypeWidget(
                                          title: 'Movies',
                                          isChecked:
                                              mediaType == MediaType.values[0],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          mediaType = MediaType.values[1];
                                          modalSheetState(() {});
                                        },
                                        child: MediaTypeWidget(
                                          title: 'Person',
                                          isChecked:
                                              mediaType == MediaType.values[1],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          mediaType = MediaType.values[2];
                                          modalSheetState(() {});
                                        },
                                        child: MediaTypeWidget(
                                          title: 'TV',
                                          isChecked:
                                              mediaType == MediaType.values[2],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      GestureDetector(
                                        onTap: () {
                                          mediaType = MediaType.values[3];
                                          modalSheetState(() {});
                                        },
                                        child: MediaTypeWidget(
                                          title: 'Collection',
                                          isChecked:
                                              mediaType == MediaType.values[3],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 44),
                            FilterBottomPart(
                              movieType: mediaType,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              child: Divider(
                                color: Color(0xFFebebeb),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Buttons.secondary(
                                      text: 'Reset',
                                      onTap: () {
                                        mediaType = MediaType.all;
                                        modalSheetState(() {});
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Buttons.primary(
                                      text: 'Apply',
                                      onTap: () {
                                        context.read<SearchMovieBloc>().add(
                                              SearchEventInitial(
                                                keyword: controller.text,
                                                arguments: SearchArguments(
                                                  mediaType: mediaType,
                                                ),
                                              ),
                                            );
                                        context.pop();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      );
                    }),
                  );
                },
              );
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
      body: BlocBuilder<SearchMovieBloc, SearchMovieState>(
        buildWhen: (context, state) {
          return state is SearchMovieLoadedState;
        },
        builder: (context, state) {
          if (state is SearchMovieLoadedState) {
            return GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              itemCount: state.data.results!.length,
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
                        extra: state.data.results![index].id);
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
                                'https://image.tmdb.org/t/p/w1280${state.data.results![index].posterPath ?? ''}'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8),
                        child: IMDbTag(
                            title: state.data.results![index].voteAverage!
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
    );
  }
}

class FilterBottomPart extends StatefulWidget {
  const FilterBottomPart({super.key, required this.movieType});

  final MediaType movieType;

  @override
  State<FilterBottomPart> createState() => _FilterBottomPartState();
}

class _FilterBottomPartState extends State<FilterBottomPart> {
  @override
  Widget build(BuildContext context) {
    switch (widget.movieType) {
      case MediaType.movie:
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  AppIcons.icCalendar,
                  const SizedBox(width: 15),
                  Text(
                    'Realese Year',
                    style: Typographies.bodyLargeBold,
                  ),
                  const Spacer(),
                  Text(
                    '2023',
                    style: Typographies.bodyLargeRegular,
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  AppIcons.icGlobe,
                  const SizedBox(width: 15),
                  Text(
                    'Country',
                    style: Typographies.bodyLargeBold,
                  ),
                  const Spacer(),
                  Text(
                    'All',
                    style: Typographies.bodyLargeRegular,
                  )
                ],
              ),
            ),
          ],
        );
      case MediaType.person:
        return const SizedBox();
      case MediaType.tv:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Row(
            children: [
              AppIcons.icCalendar,
              const SizedBox(width: 15),
              Text(
                'Realese Year',
                style: Typographies.bodyLargeBold,
              ),
              const Spacer(),
              Text(
                '2023',
                style: Typographies.bodyLargeRegular,
              )
            ],
          ),
        );
      case MediaType.collection:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Row(
            children: [
              AppIcons.icGlobe,
              const SizedBox(width: 15),
              Text(
                'Country',
                style: Typographies.bodyLargeBold,
              ),
              const Spacer(),
              Text(
                'All',
                style: Typographies.bodyLargeRegular,
              )
            ],
          ),
        );
      case MediaType.all:
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  AppIcons.icCalendar,
                  const SizedBox(width: 15),
                  Text(
                    'Realese Year',
                    style: Typographies.bodyLargeBold,
                  ),
                  const Spacer(),
                  Text(
                    '2023',
                    style: Typographies.bodyLargeRegular,
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  AppIcons.icGlobe,
                  const SizedBox(width: 15),
                  Text(
                    'Country',
                    style: Typographies.bodyLargeBold,
                  ),
                  const Spacer(),
                  Text(
                    'All',
                    style: Typographies.bodyLargeRegular,
                  )
                ],
              ),
            ),
          ],
        );
    }
  }
}
