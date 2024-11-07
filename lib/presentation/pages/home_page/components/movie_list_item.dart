import 'package:flutter/material.dart';
import 'package:movie/core/utils/extensions.dart';
import 'package:movie/data/models/movies_model.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({
    super.key,
    required this.moviesResult,
  });

  final Result moviesResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://image.tmdb.org/t/p/w1280${moviesResult.backdropPath!}',
              width: 150,
              height: 198,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            overflow: TextOverflow.ellipsis,
            moviesResult.originalTitle!,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(
                moviesResult.releaseDate!.formatedYearOfDateTime(),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 4),
              const Text(
                '·',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 4),
              Text(
                moviesResult.adult! ? "17+" : "PG",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 4),
              const Text(
                '·',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 4),
            ],
          )
        ],
      ),
    );
  }
}
