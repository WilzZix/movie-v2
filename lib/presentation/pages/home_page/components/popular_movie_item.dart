import 'package:flutter/material.dart';
import 'package:movie/core/utils/extensions.dart';
import 'package:movie/data/models/movies_model.dart';
import 'package:movie/presentation/pages/home_page/components/genre_builder.dart';
import 'package:movie/presentation/pages/home_page/components/movie_rating_widget.dart';
import 'package:movie/presentation/pages/home_page/components/text_container_widget.dart';

import 'add_to_watch_list_widget.dart';

class PopularMovieItem extends StatelessWidget {
  const PopularMovieItem({
    super.key,
    required this.movieResult,
  });

  final Result movieResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://image.tmdb.org/t/p/w1280${movieResult.backdropPath}',
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieRatingWidget(
            ratingPoint: movieResult.voteAverage!.toString(),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieResult.originalTitle!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 100,
                        height: 20,
                        child: ListView.builder(
                          itemCount: movieResult.genreIds.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return GenreBuilder(
                              genreId: movieResult.genreIds,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          TextContainerWidget(
                            title: !movieResult.adult! ? '17+' : 'GP',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          TextContainerWidget(
                            title: movieResult.releaseDate!
                                .formatedYearOfDateTime(),
                          ),
                          const SizedBox(height: 32)
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: AddToWatchListWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
