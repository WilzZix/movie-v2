import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  TextEditingController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
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
        hintStyle: Typographies.bodyMediumRegular,
        hintText: 'Search',
        filled: true,
        fillColor:
            _isFocused ? const Color(0xFFedf3ff) : GreyScale.grayScale100,
        suffixIcon: Padding(
          padding:
              const EdgeInsets.only(top: 18.0, bottom: 18, left: 20, right: 12),
          child: AppIcons.icRecord,
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
