import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/typography.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.hintText,
  });

  const InputField.username({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    required this.prefixIcon,
  });

  const InputField.email({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    required this.prefixIcon,
  });

  const InputField.password({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    required this.prefixIcon,
  });

  const InputField.normal({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    required this.prefixIcon,
  });

  const InputField.phone({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    required this.prefixIcon,
  });

  const InputField.code({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIcon,
    this.prefix,
     this.prefixIcon,
  });

  final String? hintText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (state) {
        return Container(
          decoration: BoxDecoration(
            color: GreyScale.grayScale50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              suffix: widget.suffix,
              suffixIcon: widget.suffixIcon,
              prefix: widget.prefix,
              prefixIcon: widget.prefixIcon,
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
