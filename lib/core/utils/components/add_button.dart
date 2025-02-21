import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MainPrimaryColor.primary500.withOpacity(0.08),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
