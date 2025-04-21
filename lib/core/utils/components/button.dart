import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/typography.dart';

///виды кнопок
enum _ButtonType { primary, secondary }

///закругления кнопок
enum _ButtonType3 { rounded, filled }

class Buttons extends StatefulWidget {
  const Buttons._({
    this.onTap,
    required this.text,
    required this.type,
    required this.type3,
    super.key,
  });

  const Buttons.primary({
    required String text,
    VoidCallback? onTap,
    _ButtonType3? type3,
    Key? key,
  }) : this._(
          key: key,
          text: text,
          type: _ButtonType.primary,
          onTap: onTap,
          type3: type3 ?? _ButtonType3.rounded,
        );

  const Buttons.secondary({
    required String text,
    VoidCallback? onTap,
    _ButtonType3? type3,
    Key? key,
  }) : this._(
          key: key,
          text: text,
          type: _ButtonType.secondary,
          onTap: onTap,
          type3: type3 ?? _ButtonType3.rounded,
        );
  final VoidCallback? onTap;
  final String text;
  final _ButtonType type;
  final _ButtonType3 type3;

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 58,
        decoration: _boxDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 18,
          ),
          child: Center(
            child: Text(
              widget.text,
              style: _textStyle,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration get _boxDecoration {
    switch (widget.type) {
      case _ButtonType.primary:
        return BoxDecoration(
          gradient: widget.type3 == _ButtonType3.rounded
              ? AppGradient.mainGradient
              : null,
          borderRadius: widget.type3 == _ButtonType3.rounded
              ? BorderRadius.circular(100)
              : null,
        );
      case _ButtonType.secondary:
        return BoxDecoration(
          border: Border.all(
            color: MainPrimaryColor.primary500,
          ),
          borderRadius: widget.type3 == _ButtonType3.rounded
              ? BorderRadius.circular(100)
              : null,
        );
    }
  }

  TextStyle get _textStyle {
    switch (widget.type) {
      case _ButtonType.primary:
        return Typographies.bodyLargeBold.copyWith(
          color: OtherColors.white,
        );
      case _ButtonType.secondary:
        return Typographies.bodyLargeBold
            .copyWith(color: MainPrimaryColor.primary500);
    }
  }
}
