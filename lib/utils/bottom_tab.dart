import 'package:flutter/material.dart';
import 'package:movie/utils/typography.dart';

class BottomTab extends StatelessWidget {
  const BottomTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 8.0, right: 8, bottom: MediaQuery.of(context).padding.bottom),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Pokazat',
            style: AppTypography.sampleText,
          ),
        ),
      ),
    );
  }
}
