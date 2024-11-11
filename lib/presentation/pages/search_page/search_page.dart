import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/core/utils/extensions.dart';
import 'package:movie/presentation/pages/home_page/components/genre_builder.dart';
import 'package:movie/presentation/pages/home_page/components/text_container_widget.dart';
import 'package:movie/presentation/pages/movie_detail_page/movie_detail_page.dart';

import '../home_page/components/add_to_watch_list_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool donotScroll = false;

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
          .add(SearchMovieEvent(controller.text));
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: false,
        actions: [
          SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                'assets/icons/filter-6535.svg',
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.black,
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            snap: false,
            floating: true,
            backgroundColor: Colors.black,
            title: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: 'Search...',
                suffixIcon: GestureDetector(
                  onTap: cleanSearch,
                  child: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
          BlocBuilder<MoviesBloc, MoviesState>(
            buildWhen: (context, state) {
              return state is SearchMovieLoadedState ||
                  state is LastSearchedMovieLoadedState;
            },
            builder: (context, state) {
              if (state is SearchMovieLoadingState) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is SearchMovieLoadedState) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: state.data.results!.length, (context, index) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<MoviesBloc>(context).add(
                            AddMovieToPreviousSearchResult(
                                state.data.results![index]));
                        context.pushNamed(MovieDetailPage.tag,
                            extra: state.data.results![index].id);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 200,
                              width: 100,
                              child: state.data.results![index].backdropPath !=
                                      null
                                  ? Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w1280${state.data.results![index].posterPath!}',
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 20,
                                  child: ListView.builder(
                                    itemCount: state
                                        .data.results![index].genreIds!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GenreBuilder(
                                        genreId: state
                                            .data.results![index].genreIds!,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  state.data.results![index].originalTitle!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    TextContainerWidget(
                                      title: !state.data.results![index].adult!
                                          ? '17+'
                                          : 'GP',
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    TextContainerWidget(
                                      title: state.data.results![index]
                                              .releaseDate ??
                                          '1999-07-07'.formatedYearOfDateTime(),
                                    ),
                                    const SizedBox(height: 32)
                                  ],
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          '${state.data.results![index].voteAverage!}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 55),
                                    const AddToWatchListWidget()
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }
              if (state is LastSearchedMovieLoadedState) {
                donotScroll = true;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.data.length,
                    (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          if (index == 0)
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Previous Search',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<MoviesBloc>(context).add(
                                  AddMovieToPreviousSearchResult(
                                      state.data[index]));
                              context.pushNamed(MovieDetailPage.tag,
                                  extra: state.data[index].id);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 200,
                                    width: 100,
                                    child:
                                        state.data[index].backdropPath != null
                                            ? Image(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  'https://image.tmdb.org/t/p/w1280${state.data[index].posterPath!}',
                                                ),
                                              )
                                            : null,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 20,
                                        child: ListView.builder(
                                          itemCount: state
                                              .data[index].genreIds!.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GenreBuilder(
                                              genreId:
                                                  state.data[index].genreIds!,
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        state.data[index].originalTitle!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          TextContainerWidget(
                                            title: !state.data[index].adult!
                                                ? '17+'
                                                : 'GP',
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          TextContainerWidget(
                                            title: state
                                                    .data[index].releaseDate ??
                                                '1999-07-07'
                                                    .formatedYearOfDateTime(),
                                          ),
                                          const SizedBox(height: 32)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                '${state.data[index].voteAverage!}',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 55),
                                          const AddToWatchListWidget()
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
              return const SliverToBoxAdapter();
            },
          ),
        ],
      ),
    );
  }
}
