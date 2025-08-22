import 'package:flutter/material.dart';
import 'package:movie/core/utils/icons/icons.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  final FocusNode _focusNode = FocusNode();

  TextEditingController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Search',
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 20, right: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcons.icVerticalDivider,
              const SizedBox(
                width: 12,
              ),
              AppIcons.icRecord,
            ],
          ),
        ),
        prefixIcon: Padding(
          padding:
              const EdgeInsets.only(top: 18.0, bottom: 18, left: 20, right: 12),
          child: AppIcons.icSearch,
        ),
      ),
    );
  }
}
