import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, this.actions, required this.title});

  final List<Widget>? actions;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
