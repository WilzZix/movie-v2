import 'package:flutter/material.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key});

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFedf3ff),
          borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        decoration: InputDecoration(
          hintStyle: Typographies.bodyMediumRegular,
          hintText: 'Search',
          suffixIcon: Padding(
            padding: const EdgeInsets.only(
                top: 18.0, bottom: 18, left: 20, right: 12),
            child: AppIcons.icRecord,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
                top: 18.0, bottom: 18, left: 20, right: 12),
            child: AppIcons.icSearch,
          ),
        ),
      ),
    );
  }
}
