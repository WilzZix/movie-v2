import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/typography.dart';

class MediaTypeWidget extends StatefulWidget {
  const MediaTypeWidget({
    super.key,
    required this.title,
    required this.isChecked,
  });

  final String title;
  final bool isChecked;

  @override
  State<MediaTypeWidget> createState() => _MediaTypeWidgetState();
}

class _MediaTypeWidgetState extends State<MediaTypeWidget> {
  bool get _isChecked => widget.isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: _isChecked ? MainPrimaryColor.primary500 : OtherColors.white,
        borderRadius: BorderRadius.circular(100),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
        child: Text(
          widget.title,
          style: _isChecked
              ? Typographies.bodyLargeBold.copyWith(
                  color: OtherColors.white,
                )
              : Typographies.bodyLargeBold,
        ),
      ),
    );
  }
}
