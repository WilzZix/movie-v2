import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

///виды кнопок
enum _ButtonType { primary, secondary, social }

///закругления кнопок
enum ButtonType3 {
  rounded,
  filled,
  apple,
  google,
  facebook,
}

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
    ButtonType3? type3,
    Key? key,
  }) : this._(
          key: key,
          text: text,
          type: _ButtonType.primary,
          onTap: onTap,
          type3: type3 ?? ButtonType3.rounded,
        );

  const Buttons.secondary({
    required String text,
    VoidCallback? onTap,
    ButtonType3? type3,
    Key? key,
  }) : this._(
          key: key,
          text: text,
          type: _ButtonType.secondary,
          onTap: onTap,
          type3: type3 ?? ButtonType3.rounded,
        );

  const Buttons.social({
    String? text,
    VoidCallback? onTap,
    required ButtonType3 type3,
    Key? key,
  }) : this._(
          key: key,
          text: text ?? '',
          type: _ButtonType.social,
          onTap: onTap,
          type3: type3,
        );
  final VoidCallback? onTap;
  final String text;
  final _ButtonType type;
  final ButtonType3 type3;

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
          child: child(widget.type3),
        ),
      ),
    );
  }

  Widget child(ButtonType3 type) {
    switch (type) {
      case ButtonType3.rounded:
        return Center(
          child: Text(
            widget.text,
            style: _textStyle,
          ),
        );
      case ButtonType3.filled:
        return Center(
          child: Text(
            widget.text,
            style: _textStyle,
          ),
        );
      case ButtonType3.apple:
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcons.icApple,
              const SizedBox(width: 12),
              Text(
                'Continue with Apple',
                style: Typographies.bodyLargeSemiBold,
              )
            ],
          ),
        );
      case ButtonType3.google:
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcons.icGoogle,
              const SizedBox(width: 12),
              Text(
                'Continue with Google',
                style: Typographies.bodyLargeSemiBold,
              )
            ],
          ),
        );
      case ButtonType3.facebook:
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcons.icFacebook,
              const SizedBox(width: 12),
              Text(
                'Continue with Facebook',
                style: Typographies.bodyLargeSemiBold,
              )
            ],
          ),
        );
    }
  }

  BoxDecoration get _boxDecoration {
    switch (widget.type) {
      case _ButtonType.primary:
        return BoxDecoration(
            gradient: widget.type3 == ButtonType3.rounded
                ? AppGradient.mainGradient
                : null,
            borderRadius: widget.type3 == ButtonType3.rounded
                ? BorderRadius.circular(100)
                : null,
            color: widget.type3 == ButtonType3.rounded
                ? MainPrimaryColor.primary100
                : null);
      case _ButtonType.secondary:
        return BoxDecoration(
          color: MainPrimaryColor.primary100,
          borderRadius: widget.type3 == ButtonType3.rounded
              ? BorderRadius.circular(100)
              : null,
        );
      case _ButtonType.social:
        return BoxDecoration(
            border: Border.all(
              color: GreyScale.grayScale200,
            ),
            borderRadius: BorderRadius.circular(16));
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
      case _ButtonType.social:
        return Typographies.bodyLargeSemiBold
            .copyWith(color: GreyScale.grayScale900);
    }
  }
}
