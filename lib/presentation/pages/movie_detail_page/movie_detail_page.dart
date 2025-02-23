import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/application/actors/actors_bloc.dart';
import 'package:movie/application/movies_blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie/application/movies_blocs/movie_trailer_videos/trailer_videos_cubit.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/add_button.dart';
import 'package:movie/core/utils/components/tags.dart';
import 'package:movie/core/utils/helpfull_functions/helpfull_functions.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
          create: (context) => MovieDetailBloc(),
        ),
        BlocProvider(
          create: (context) =>
              TrailerVideosCubit()..getTrailerVideos(movieId: widget.movieId),
        ),
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
                              onTap: () {},
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
                        children: const [
                          Center(child: Text('About the Movie')),
                          Center(child: Text('Comments Section')),
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
