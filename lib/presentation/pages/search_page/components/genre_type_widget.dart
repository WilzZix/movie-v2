import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/typography.dart';

class GenreTypeWidget extends StatefulWidget {
  const GenreTypeWidget({
    super.key,
    required this.title,
    required this.isChecked,
  });

  final String title;
  final bool isChecked;

  @override
  State<GenreTypeWidget> createState() => _GenreTypeWidgetState();
}

class _GenreTypeWidgetState extends State<GenreTypeWidget> {
  bool get _isChecked => widget.isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: _isChecked ? MainPrimaryColor.primary500 : OtherColors.white,
        borderRadius: BorderRadius.circular(100),
        border: !_isChecked ? Border.all(color: GreyScale.grayScale100) : null,
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Text(
          widget.title,
          style: _isChecked
              ? Typographies.bodyLargeSemiBold.copyWith(
                  color: OtherColors.white,
                )
              : Typographies.bodyLargeSemiBold,
        ),
      ),
    );
  }
}
