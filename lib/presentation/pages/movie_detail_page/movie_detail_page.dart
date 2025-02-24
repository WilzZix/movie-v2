import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/actors/actors_bloc.dart';
import 'package:movie/application/movies_blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie/application/movies_blocs/movie_trailer_videos/trailer_videos_cubit.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/application/movies_blocs/recommended_movies/recommended_movies_cubit.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/add_button.dart';
import 'package:movie/core/utils/components/tags.dart';
import 'package:movie/core/utils/helpfull_functions/helpfull_functions.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../home_page/components/video_player_page.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movieId});

  static const String tag = 'movie-detail-page';
  final int movieId;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    BlocProvider.of<MoviesBloc>(context)
        .add(GetMovieDetailsEvent(widget.movieId));
    BlocProvider.of<ActorsBloc>(context)
        .add(GetMovieActorsEvent(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieDetailBloc()
            ..add(GetMovieGalleryEvent(movieId: widget.movieId)),
        ),
        BlocProvider(
          create: (context) =>
              TrailerVideosCubit()..getTrailerVideos(movieId: widget.movieId),
        ),
        BlocProvider(
          create: (context) => RecommendedMoviesCubit()
            ..getRecommendedMovies(movieId: widget.movieId),
        )
      ],
      child: Scaffold(
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MovieDetailsLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                context.pushNamed(VideoPlayerPage.tag,
                                    extra: state.data.$1.id.toString());
                              },
                              child: Container(
                                height: 440,
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
                                      'https://image.tmdb.org/t/p/w1280${state.data.$1.backdropPath}',
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Spacer(),
                                    AppIcons.icPlayVideoIcon,
                                    const SizedBox(height: 16),
                                    Text(
                                      state.data.$1.originalTitle!,
                                      style: Typographies.heading4.copyWith(
                                          color: MainPrimaryColor.primary100),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.0,
                            right: 24,
                            top: 24 + MediaQuery.of(context).padding.top,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppIcons.icAppIcon,
                              AppIcons.icChromeCastIcon,
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AddButton(
                          icon: AppIcons.icDownloadIcon,
                        ),
                        AddButton(
                          icon: AppIcons.icBookMark,
                        ),
                        AddButton(
                          icon: AppIcons.icSend,
                        ),
                        AddButton(
                          icon: AppIcons.icMoreCircle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          VotingStarWithRating(
                            averageVote:
                                state.data.$1.voteAverage!.toStringAsFixed(1),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '•',
                            style: Typographies.bodySmallBold,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            MinutesToHourAndMin.minutesToHours(
                                state.data.$1.runtime!),
                            style: Typographies.bodySmallBold,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '•',
                            style: Typographies.bodySmallBold,
                          ),
                          const SizedBox(width: 8),
                          // SizedBox(
                          //   height: 20,
                          //   child: ListView.builder(
                          //     scrollDirection: Axis.horizontal,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     itemCount: state.data.$1.genres!.length,
                          //     itemBuilder: (context, index) {
                          //       return Text(
                          //         GenreIdTOStringName.getGenreName(
                          //             state.data.$1.genres![index].id!),
                          //         style: Typographies.bodySmallBold,
                          //       );
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TagComponent(
                            title: GenreIdTOStringName.getGenreName(
                                state.data.$1.genres!.first.id!),
                          ),
                          const SizedBox(width: 12),
                          TagComponent(
                            title: DateTime.parse(state.data.$1.releaseDate!)
                                .year
                                .toString(),
                          ),
                          const SizedBox(width: 12),
                          TagComponent(
                            title: state.data.$1.originalLanguage!,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        state.data.$1.overview!,
                        style: Typographies.bodyMediumMedium,
                      ),
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<TrailerVideosCubit, TrailerVideosState>(
                      buildWhen: (context, state) {
                        return state is TrailerVideosLoadedState;
                      },
                      builder: (context, state) {
                        if (state is TrailerVideosLoadedState) {
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 114,
                                        width: 189,
                                        child: YoutubePlayer(
                                          controller: YoutubePlayerController(
                                            initialVideoId:
                                                state.data[index].key,
                                            flags: const YoutubePlayerFlags(
                                              autoPlay: false,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Text(
                                          softWrap: true,
                                          state.data[index].name,
                                          style: Typographies.bodyMediumBold,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 24)
                                ],
                              );
                            },
                          );
                        }
                        return CircularProgressIndicator(
                          color: MainPrimaryColor.primary500,
                        );
                      },
                    ),
                    TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.blue,
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(text: 'More Like This'),
                        Tab(text: 'About'),
                        Tab(text: 'Comments'),
                      ],
                    ),
                    SizedBox(
                      height: 300, // Adjust the height for the tab content
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          BlocBuilder<RecommendedMoviesCubit,
                              RecommendedMoviesState>(
                            builder: (context, state) {
                              if (state is RecommendedVideosLoadedState) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.data.results!.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        context.pushNamed(MovieDetailPage.tag,
                                            extra:
                                                state.data.results![index].id);
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8),
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IMDbTag(
                                                  title: state
                                                      .data
                                                      .results![index]
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
                                );
                              }
                              return CircularProgressIndicator(
                                  color: MainPrimaryColor.primary500);
                            },
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Subtitles:',
                                        style: Typographies.bodyMediumSemiBold
                                            .copyWith(
                                                color: GreyScale.grayScale400),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        state.data.$1.originalLanguage!,
                                        style: Typographies.bodyMediumSemiBold,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Audio Track:',
                                        style: Typographies.bodyMediumSemiBold
                                            .copyWith(
                                                color: GreyScale.grayScale400),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        state.data.$1.originalLanguage!,
                                        style: Typographies.bodyMediumSemiBold,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    'Cast and Crew',
                                    style: Typographies.heading4,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                BlocBuilder<ActorsBloc, ActorsState>(
                                  buildWhen: (context, state) {
                                    return state is MovieActorsLoadedState;
                                  },
                                  builder: (context, state) {
                                    if (state is MovieActorsLoadedState) {
                                      return SizedBox(
                                        height: 70,
                                        child: ListView.builder(
                                          itemCount: 10,
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: 70,
                                              margin: const EdgeInsets.only(
                                                  right: 8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 70,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            "https://image.tmdb.org/t/p/w1280${state.data[index].profilePath}"),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        state.data[index].name!,
                                                        style: Typographies
                                                            .bodySmallSemiBold,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        state.data[index]
                                                            .originalName!,
                                                        style: Typographies
                                                            .bodySmallRegular,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                    return CircularProgressIndicator(
                                      color: MainPrimaryColor.primary500,
                                    );
                                  },
                                ),
                                const SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Gallery',
                                        style: Typographies.heading5,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          'See all',
                                          style: Typographies.bodyMediumSemiBold
                                              .copyWith(
                                                  color: MainPrimaryColor
                                                      .primary500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                BlocBuilder<MovieDetailBloc, MovieDetailState>(
                                  buildWhen: (context, state) {
                                    return state is MovieGalleryLoadedState;
                                  },
                                  builder: (context, state) {
                                    if (state is MovieGalleryLoadedState) {
                                      return SizedBox(
                                        height: 113,
                                        width: 189,
                                        child: ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          itemCount: state.data.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://image.tmdb.org/t/p/w1280${state.data[index].filePath}"),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                    return CircularProgressIndicator(
                                        color: MainPrimaryColor.primary500);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Center(child: Text('Comments Section')),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
