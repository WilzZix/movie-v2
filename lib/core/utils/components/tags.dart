import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

class TagComponent extends StatelessWidget {
  const TagComponent({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            Color(0xFF4AB9FF),
            Color(0xFF0084F3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 6, right: 10, bottom: 6, left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            width: 1,
            color: const Color(0xFF4AB9FF),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: Typographies.bodyXSmallSemiBold.copyWith(
              color: const Color(0xFF4AB9FF),
            ),
          ),
        ),
      ),
    );
  }
}

class IMDbTag extends StatelessWidget {
  const IMDbTag({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 68,
      padding: const EdgeInsets.only(top: 6, right: 10, bottom: 6, left: 10),
      decoration: BoxDecoration(
        color: const Color(0x59757F8B),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Image.asset(AppPngIcons.icImdb),
          const SizedBox(width: 5),
          Text(
            title,
            style: Typographies.bodyXSmallSemiBold,
          ),
        ],
      ),
    );
  }
}

class VotingStarWithRating extends StatelessWidget {
  const VotingStarWithRating({super.key, required this.averageVote});

  final String averageVote;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIcons.icStarHalfColored,
        const SizedBox(width: 8),
        Text(averageVote,style: Typographies.bodySmallBold.copyWith(color: MainPrimaryColor.primary500),)
      ],
    );
  }
}
