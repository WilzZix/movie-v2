import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

class SelectedFilterItems extends StatelessWidget {
  const SelectedFilterItems({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
          color: MainPrimaryColor.primary500,
          borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: [
          Text(
            title,
            style: Typographies.bodyLargeSemiBold.copyWith(color: Colors.white),
          ),
          const SizedBox(
            width: 8,
          ),
          AppIcons.icClose
        ],
      ),
    );
  }
}
