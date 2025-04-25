import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum InputFieldState { defaultState, active, filled }

final uzPhoneMask = MaskTextInputFormatter(
  mask: '+998 ## ### ## ##',
  filter: {"#": RegExp(r'\d')},
);

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.suffix,
    this.suffixIconPath,
    this.prefix,
    this.prefixIconPath,
    this.hintText,
    this.inputFormatter,
    required this.focusNode,
    required this.controller,
    this.fieldWidth,
  }) : textInputType = TextInputType.text;

  const InputField.username({
    super.key,
    this.hintText,
    this.suffix,
    this.inputFormatter,
    this.suffixIconPath,
    this.prefix,
    required this.focusNode,
    required this.controller,
    this.fieldWidth,
  })  : prefixIconPath = AppIcons.icInputFieldPerson,
        textInputType = TextInputType.text;

  const InputField.email({
    super.key,
    this.hintText,
    this.suffix,
    this.inputFormatter,
    this.suffixIconPath,
    this.prefix,
    required this.focusNode,
    required this.controller,
    this.fieldWidth,
  })  : prefixIconPath = AppIcons.icInputFieldEmail,
        textInputType = TextInputType.emailAddress;

  const InputField.password({
    super.key,
    this.hintText,
    this.suffix,
    this.prefix,
    this.inputFormatter,
    required this.focusNode,
    required this.controller,
    this.fieldWidth,
  })  : prefixIconPath = AppIcons.icInputFieldPassword,
        suffixIconPath = AppIcons.icInputFieldCloseEye,
        textInputType = TextInputType.visiblePassword;

  const InputField.normal({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIconPath,
    this.prefix,
    this.inputFormatter,
    required this.focusNode,
    required this.controller,
    this.fieldWidth,
  })  : prefixIconPath = AppIcons.icInputFieldCloseEye,
        textInputType = TextInputType.text;

  InputField.phone({
    super.key,
    this.hintText,
    this.suffix,
    this.prefix,
    required this.focusNode,
    required this.controller,
    this.fieldWidth,
  })  : prefixIconPath = AppIcons.icInputFieldPerson,
        suffixIconPath = AppIcons.icInputFieldArrowDown,
        textInputType = TextInputType.phone,
        inputFormatter = uzPhoneMask;

  const InputField.code({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIconPath,
    this.inputFormatter,
    this.prefix,
    this.prefixIconPath,
    required this.focusNode,
    required this.controller,
  })  : fieldWidth = 78,
        textInputType = TextInputType.phone;

  final String? hintText;
  final Widget? suffix;
  final String? suffixIconPath;
  final Widget? prefix;
  final String? prefixIconPath;
  final double? fieldWidth;
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputType textInputType;
  final MaskTextInputFormatter? inputFormatter;

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
          width: widget.fieldWidth,
          decoration: BoxDecoration(
            color: containerBgColor(_fieldState),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            textAlign:
                widget.fieldWidth != null ? TextAlign.center : TextAlign.start,
            style: Typographies.bodyMediumSemiBold,
            inputFormatters:
                widget.inputFormatter != null ? [widget.inputFormatter!] : null,
            keyboardType: widget.textInputType,
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

class TextInputFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    throw UnimplementedError();
  }
}
