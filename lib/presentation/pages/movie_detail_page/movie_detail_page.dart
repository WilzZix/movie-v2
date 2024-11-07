import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:movie/application/actors/actors_bloc.dart';
import 'package:movie/application/movies_blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/core/utils/extensions.dart';
import 'package:movie/data/models/actor_model.dart';
import 'package:movie/presentation/pages/home_page/components/genre_builder.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../home_page/components/text_container_widget.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movieId});

  static const String tag = 'movie-detail-page';
  final int movieId;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context)
        .add(GetMovieDetailsEvent(widget.movieId));
    BlocProvider.of<ActorsBloc>(context)
        .add(GetMovieActorsEvent(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: const Text(
            'Movie Details',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MovieDetailsLoadedState) {
              _controller = YoutubePlayerController(
                initialVideoId: state.data.$2,
                flags: const YoutubePlayerFlags(
                  autoPlay: false,
                ),
              );
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoutubePlayer(controller: _controller),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: ListView.builder(
                        itemCount: state.data.$1.genres!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          List<int> genreIds = state.data.$1.genres!
                              .map((genre) => genre.id!)
                              .toList();
                          return GenreBuilder(
                            genreId: genreIds,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      state.data.$1.originalTitle!,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        TextContainerWidget(
                          title: !state.data.$1.adult! ? '17+' : 'GP',
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        TextContainerWidget(
                          title: state.data.$1.releaseDate!
                              .formatedYearOfDateTime(),
                        ),
                        const SizedBox(height: 32)
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      state.data.$1.overview!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<MovieDetailBloc, MovieDetailState>(
                      builder: (context, state) {
                        if (state is MovieAddedToWatchList) {
                          return Container(
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(
                                6,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Movie added to watchlist',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        }
                        if (state is AddingMovieToWatchList) {
                          return Container(
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(
                                6,
                              ),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<MovieDetailBloc>(context)
                                .add(AddMovieToWatchList(widget.movieId));
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(
                                6,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Add to watchlist',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Overall Rating',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text('${state.data.$1.voteAverage}',
                                style: const TextStyle(color: Colors.white)),
                            const SizedBox(
                              height: 8,
                            ),
                            StarRatingWidget(
                                voteRating: state.data.$1.voteAverage! / 2)
                          ],
                        ),
                        const VerticalDivider(
                          width: 20,
                          thickness: 1,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.white,
                        ),
                        const Column(
                          children: [
                            Text('Your Rating',
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 8,
                            ),
                            Text('0', style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 8,
                            ),
                            StarRatingWidget(
                              voteRating: 0,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<ActorsBloc, ActorsState>(
                      builder: (context, state) {
                        if (state is MovieActorsLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is MovieActorsLoadedState) {
                          return MoviePersonsWidget(
                            data: state.data,
                          );
                        }
                        if (state is MovieActorLoadingErrorState) {
                          return Center(
                            child: Text(
                              state.msg,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    )
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

class MoviePersonsWidget extends StatelessWidget {
  const MoviePersonsWidget({
    super.key,
    required this.data,
  });

  final List<ActorModel> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Cast',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '·',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'Writter',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '·',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'Director',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 4,
            ),
            Spacer(),
            Text(
              'See all',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            itemCount: data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data[index].profilePath == null
                              ? 'https://stock.adobe.com/uz/images/monochrome-icon/65772719'
                              : 'https://image.tmdb.org/t/p/original${data[index].profilePath!}'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      data[index].originalName!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({super.key, required this.voteRating});

  final double voteRating;

  @override
  Widget build(BuildContext context) {
    return StarRating(
      rating: voteRating,
    );
  }
}
