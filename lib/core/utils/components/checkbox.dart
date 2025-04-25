import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';

class AppCheckbox extends StatefulWidget {
  const AppCheckbox({super.key});

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 3,
          color: MainPrimaryColor.primary500,
        ),
      ),
    );
  }
}
