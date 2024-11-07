import 'package:flutter/material.dart';

class MovieRatingWidget extends StatelessWidget {
  const MovieRatingWidget({
    super.key,
    required this.ratingPoint,
  });

  final String ratingPoint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              ratingPoint,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
