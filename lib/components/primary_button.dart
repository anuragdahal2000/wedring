import 'package:flutter/material.dart';
import 'package:wedring/utils/constant.dart';

enum Variant { solid, outline, disabled, teritary }

class PrimaryButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final Icon? icon;
  final double? horizontalIconSpace;
  final EdgeInsets? padding;
  final Variant? variant;

  PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.horizontalIconSpace = 4,
    this.icon,
    this.padding,
    this.variant = Variant.solid,
  }) : super(key: key);

  late final MaterialStateProperty<EdgeInsetsGeometry?> _buttonPadding =
      MaterialStateProperty.all(
    padding ??
        const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
  );
  late final MaterialStateProperty<OutlinedBorder?> _buttonShape =
      MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case Variant.outline:
        return OutlinedButton(
          style: ButtonStyle(
            padding: _buttonPadding,
            side: MaterialStateProperty.all(
              const BorderSide(
                color: kPrimaryColor1,
              ),
            ),
            shape: _buttonShape,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon ?? const SizedBox(),
              Text(
                title!,
                style: kSemiBold16.copyWith(
                  color: kPrimaryColor1,
                ),
              ),
            ],
          ),
        );
      case Variant.disabled:
        return TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xffC4C4C4),
              ),
              foregroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
              padding: _buttonPadding,
              shape: _buttonShape),
          onPressed: null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon ?? const SizedBox(),
              Text(
                title!,
                style: kSemiBold16,
              ),
            ],
          ),
        );
      case Variant.teritary:
        return TextButton(
          style: ButtonStyle(
            padding: _buttonPadding,
            foregroundColor: MaterialStateProperty.all(
              kPrimaryColor1,
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon ?? const SizedBox(),
              Text(
                title!,
                style: kSemiBold16,
              ),
            ],
          ),
        );
      default:
        return TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kPrimaryColor1),
              foregroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
              padding: _buttonPadding,
              shape: _buttonShape),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? const SizedBox.shrink(),
              (icon != null)
                  ? SizedBox(
                      width: horizontalIconSpace,
                    )
                  : const SizedBox.shrink(),
              Text(
                title!,
                style: kSemiBold16.copyWith(
                  color: kBackgroundColor2,
                ),
              ),
            ],
          ),
        );
    }
  }
}
