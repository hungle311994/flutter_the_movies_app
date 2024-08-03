import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final barrierColor = color(AppColor.background).withOpacity(0.8);
final successToastColor = color(AppColor.main).withOpacity(0.7);
final errorToastColor = color(AppColor.error).withOpacity(0.7);

Gradient gradientColor = LinearGradient(
  colors: [
    color(AppColor.primary),
    color(AppColor.secondary),
  ],
);

Gradient gradientColorBlurBottom = LinearGradient(
  colors: [
    color(AppColor.background),
    Colors.transparent,
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  stops: [0.0, 1.0],
  tileMode: TileMode.clamp,
);

Gradient gradientColorBlurTop = LinearGradient(
  colors: [
    color(AppColor.background),
    Colors.transparent,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  tileMode: TileMode.clamp,
);

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

enum AppColor {
  main,
  defaultText,
  darkGrey,
  darkerGrey,
  darkestGrey,
  darkestGrey1,
  brightGrey,
  outlineBorderGrey,
  background,
  bookmarked,
  green,
  darkBlue,
  error,
  lightGreen,
  primary,
  secondary,
  warning,
  success,
  lightGrey,
  disable,
  grey,
  indicatorActive,
  lightBlue,
  white,
  lightYellow,
  noImageBackground,
}

HexColor color(AppColor color) {
  switch (color) {
    case AppColor.white:
      return HexColor('#FFFFFF');
    case AppColor.primary:
      return HexColor('#09abcc');
    case AppColor.secondary:
      return HexColor('#6853a0');
    case AppColor.main:
      return HexColor('#4284E4');
    case AppColor.lightBlue:
      return HexColor('#729EE3');
    case AppColor.darkBlue:
      return HexColor('#2D5CAF');
    case AppColor.outlineBorderGrey:
      return HexColor('#D0D6DA');
    case AppColor.background:
      return HexColor('#0b0b0b');
    case AppColor.defaultText:
      return HexColor('#2D383D');
    case AppColor.brightGrey:
      return HexColor('#98A9B0');
    case AppColor.lightGrey:
      return HexColor('#8C9BA3');
    case AppColor.grey:
      return HexColor('#697983');
    case AppColor.darkGrey:
      return HexColor('#657A84');
    case AppColor.darkerGrey:
      return HexColor('#313338');
    case AppColor.darkestGrey:
      return HexColor('#1C1C1C');
    case AppColor.darkestGrey1:
      return HexColor('#0F0F0F');
    case AppColor.bookmarked:
      return HexColor('#11B7A8');
    case AppColor.lightGreen:
      return HexColor('#c5f4c5');
    case AppColor.green:
      return HexColor('#65C15E');
    case AppColor.error:
      return HexColor('#F55361');
    case AppColor.warning:
      return HexColor('#DCB823');
    case AppColor.lightYellow:
      return HexColor('#FFD900');
    case AppColor.success:
      return HexColor('#0AAACE');
    case AppColor.disable:
      return HexColor('#E7EBEC');
    case AppColor.indicatorActive:
      return HexColor('#4284E4');
    case AppColor.noImageBackground:
      return HexColor('#D0D5DA');
  }
}
