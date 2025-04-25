import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

enum InputFieldState { defaultState, active, filled }

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.suffix,
    this.suffixIconPath,
    this.prefix,
    this.prefixIconPath,
    this.hintText,
    required this.focusNode,
    required this.controller,
  });

  const InputField.username({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIconPath,
    this.prefix,
    required this.focusNode,
    required this.controller,
  }) : prefixIconPath = AppIcons.icInputFieldPerson;

  const InputField.email({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIconPath,
    this.prefix,
    required this.focusNode,
    required this.controller,
  }) : prefixIconPath = AppIcons.icInputFieldEmail;

  const InputField.password({
    super.key,
    this.hintText,
    this.suffix,
    this.prefix,
    required this.focusNode,
    required this.controller,
  })  : prefixIconPath = AppIcons.icInputFieldPassword,
        suffixIconPath = AppIcons.icInputFieldCloseEye;

  const InputField.normal({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIconPath,
    this.prefix,
    required this.focusNode,
    required this.controller,
  }) : prefixIconPath = AppIcons.icInputFieldCloseEye;

  const InputField.phone({
    super.key,
    this.hintText,
    this.suffix,
    this.prefix,
    required this.focusNode,
    required this.controller,
  })  : prefixIconPath = AppIcons.icInputFieldPerson,
        suffixIconPath = AppIcons.icInputFieldArrowDown;

  const InputField.code({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIconPath,
    this.prefix,
    this.prefixIconPath,
    required this.focusNode,
    required this.controller,
  });

  final String? hintText;
  final Widget? suffix;
  final String? suffixIconPath;
  final Widget? prefix;
  final String? prefixIconPath;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  InputFieldState _fieldState = InputFieldState.defaultState;

  @override
  void initState() {
    super.initState();

    // Listen for focus changes
    widget.focusNode.addListener(() {
      _updateState();
    });

    // Listen for text changes
    widget.controller.addListener(() {
      _updateState();
    });
  }

  void _updateState() {
    setState(() {
      if (widget.focusNode.hasFocus) {
        _fieldState = InputFieldState.active;
      } else if (widget.controller.text.isNotEmpty) {
        _fieldState = InputFieldState.filled;
      } else {
        _fieldState = InputFieldState.defaultState;
      }
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    widget.focusNode.dispose();
    super.dispose();
  }

  Color containerBgColor(InputFieldState fieldState) {
    switch (fieldState) {
      case InputFieldState.defaultState:
        return GreyScale.grayScale50;
      case InputFieldState.active:
        return const Color(0xFFE0E6F5);
      case InputFieldState.filled:
        return GreyScale.grayScale50;
    }
  }

  Color prefixIconColor(InputFieldState fieldState) {
    switch (fieldState) {
      case InputFieldState.defaultState:
        return GreyScale.grayScale500;
      case InputFieldState.active:
        return MainPrimaryColor.primary500;
      case InputFieldState.filled:
        return GreyScale.grayScale900;
    }
  }

  Color suffixIconColor(InputFieldState fieldState) {
    switch (fieldState) {
      case InputFieldState.defaultState:
        return GreyScale.grayScale500;
      case InputFieldState.active:
        return MainPrimaryColor.primary500;
      case InputFieldState.filled:
        return GreyScale.grayScale900;
    }
  }

  Widget prefixIcon(String path, InputFieldState fieldState) {
    return SvgPicture.asset(
      'assets/icons/$path',
      color: prefixIconColor(fieldState),
    );
  }

  Widget suffixIcon(String path, InputFieldState fieldState) {
    return SvgPicture.asset(
      'assets/icons/$path',
      color: prefixIconColor(fieldState),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (state) {
        return Container(
          decoration: BoxDecoration(
            color: containerBgColor(_fieldState),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            style: Typographies.bodyMediumSemiBold,
            focusNode: widget.focusNode,
            controller: widget.controller,
            decoration: InputDecoration(
              suffix: widget.suffix,
              suffixIcon: widget.suffixIconPath != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 12, bottom: 18, right: 20),
                      child: suffixIcon(widget.suffixIconPath!, _fieldState),
                    )
                  : null,
              prefix: widget.prefix,
              prefixIcon: widget.prefixIconPath != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 20, bottom: 18, right: 12),
                      child: prefixIcon(widget.prefixIconPath!, _fieldState),
                    )
                  : null,
              hintText: widget.hintText,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: SecondaryPrimaryColor.primary200),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: MainPrimaryColor.primary500),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MainPrimaryColor.primary500),
                borderRadius: BorderRadius.circular(12),
              ),
              hintStyle: Typographies.bodyMediumRegular.copyWith(
                color: GreyScale.grayScale500,
              ),
            ),
          ),
        );
      },
    );
  }
}
