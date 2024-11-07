import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/movies_blocs/see_all_movies/see_all_movies_bloc.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/presentation/pages/movie_detail_page/movie_detail_page.dart';

class SeeAllMoviesPage extends StatefulWidget {
  const SeeAllMoviesPage({super.key, required this.seeAllMoviesEntity});

  static String tag = 'see-all-movies';
  final SeeAllMoviesEntity seeAllMoviesEntity;

  @override
  State<SeeAllMoviesPage> createState() => _SeeAllMoviesPageState();
}

class _SeeAllMoviesPageState extends State<SeeAllMoviesPage> {
  ScrollController scrollController = ScrollController();
  int page = 1;
  List<Result>? results = [];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMore);
    BlocProvider.of<SeeAllMoviesBloc>(context).add(
      FetchSeeAllMoviesEvent(page: 1, type: widget.seeAllMoviesEntity.event),
    );
  }

  void _loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<SeeAllMoviesBloc>(context).add(FetchSeeAllMoviesEvent(
          page: ++page, type: widget.seeAllMoviesEntity.event));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.seeAllMoviesEntity.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<SeeAllMoviesBloc, SeeAllMoviesState>(
        buildWhen: (prev, current) {
          return current is SeeAllMoviesLoaded;
        },
        builder: (context, state) {
          if (state is SeeAllMoviesLoaded) {
            results!.addAll(state.result.results!);
            return GridView.builder(
              itemCount: results!.length,
              controller: scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed(MovieDetailPage.tag,
                              extra: results![index].id);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              'https://image.tmdb.org/t/p/w1280${results![index].backdropPath!}',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              results![index].originalTitle!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 24,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            results![index].voteAverage!.toStringAsFixed(1),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}

class SeeAllMoviesEntity {
  final String title;
  final MovieType event;

  SeeAllMoviesEntity(this.title, this.event);
}
