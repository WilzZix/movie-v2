import 'package:flutter/material.dart';

class AddToWatchListWidget extends StatelessWidget {
  const AddToWatchListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(
          6,
        ),
      ),
      child: const Text(
        'Add to watchlist',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
