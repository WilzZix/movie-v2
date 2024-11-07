import 'package:flutter/material.dart';

class GenreBuilder extends StatelessWidget {
  const GenreBuilder({
    super.key,
    required this.genreId,
  });

  final List<int> genreId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
          itemCount: genreId.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            switch (genreId[index]) {
              case 28:
                return const Text(
                  'Action',
                  style: TextStyle(color: Colors.white),
                );
              case 12:
                return const Text(
                  'Adventure',
                  style: TextStyle(color: Colors.white),
                );
              case 16:
                return const Text(
                  'Animation',
                  style: TextStyle(color: Colors.white),
                );
              case 35:
                return const Text(
                  'Comedy',
                  style: TextStyle(color: Colors.white),
                );
              case 80:
                return const Text(
                  'Crime',
                  style: TextStyle(color: Colors.white),
                );
              case 99:
                return const Text(
                  'Documentary',
                  style: TextStyle(color: Colors.white),
                );
              case 18:
                return const Text(
                  'Drama',
                  style: TextStyle(color: Colors.white),
                );
              case 10751:
                return const Text(
                  'Family',
                  style: TextStyle(color: Colors.white),
                );
              case 14:
                return const Text(
                  'Fantasy',
                  style: TextStyle(color: Colors.white),
                );
              case 36:
                return const Text(
                  'History',
                  style: TextStyle(color: Colors.white),
                );
              case 27:
                return const Text(
                  'Horror',
                  style: TextStyle(color: Colors.white),
                );
              case 10402:
                return const Text(
                  'Music',
                  style: TextStyle(color: Colors.white),
                );
              case 9648:
                return const Text(
                  'Mystery',
                  style: TextStyle(color: Colors.white),
                );
              case 10749:
                return const Text(
                  'Romance',
                  style: TextStyle(color: Colors.white),
                );
              case 878:
                return const Text(
                  'Science Fiction',
                  style: TextStyle(color: Colors.white),
                );
              case 10770:
                return const Text(
                  'TV Movie',
                  style: TextStyle(color: Colors.white),
                );
              case 53:
                return const Text(
                  'Thriller',
                  style: TextStyle(color: Colors.white),
                );
              case 10752:
                return const Text(
                  'War',
                  style: TextStyle(color: Colors.white),
                );
              case 37:
                return const Text(
                  'Western',
                  style: TextStyle(color: Colors.white),
                );
              case 0:
                return const Text(
                  'Unknown',
                  style: TextStyle(color: Colors.white),
                );
              default:
                return const SizedBox();
            }
          }),
    );
  }
}
