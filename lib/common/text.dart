import 'package:flutter/material.dart';
import 'package:the_movie_app/common/color.dart';

Text whiteTxt({
  required String text,
  double size = 13,
  FontWeight weight = FontWeight.normal,
  TextAlign align = TextAlign.left,
  double height = 1.4,
  TextOverflow overflow = TextOverflow.ellipsis,
  bool softWrap = false,
  int maxLines = 4,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color(AppColor.white),
      fontWeight: weight,
      height: height,
    ),
    textAlign: align,
    softWrap: softWrap,
    overflow: overflow,
    maxLines: maxLines,
  );
}

Text brightGreyTxt({
  required String text,
  double size = 13,
  FontWeight weight = FontWeight.normal,
  TextAlign align = TextAlign.left,
  double height = 1.4,
  TextOverflow overflow = TextOverflow.ellipsis,
  bool softWrap = false,
  int maxLines = 4,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color(AppColor.brightGrey),
      fontWeight: weight,
      height: height,
    ),
    textAlign: align,
    softWrap: softWrap,
    overflow: overflow,
    maxLines: maxLines,
  );
}

Text defaultTxt({
  required String text,
  double size = 13,
  FontWeight weight = FontWeight.normal,
  TextAlign align = TextAlign.left,
  double height = 1.4,
  TextOverflow overflow = TextOverflow.ellipsis,
  bool softWrap = false,
  int maxLines = 4,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color(AppColor.defaultText),
      fontWeight: weight,
      height: height,
    ),
    textAlign: align,
    softWrap: softWrap,
    overflow: overflow,
    maxLines: maxLines,
  );
}

Text mainTxt({
  required String text,
  double size = 13,
  FontWeight weight = FontWeight.normal,
  TextAlign align = TextAlign.left,
  double height = 1.4,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color(AppColor.primary),
      fontWeight: weight,
      height: height,
    ),
    textAlign: align,
    softWrap: false,
    overflow: TextOverflow.ellipsis,
  );
}

Text errorTxt({
  required String text,
  double size = 13,
  FontWeight weight = FontWeight.normal,
  TextAlign align = TextAlign.left,
  double height = 1.4,
  TextOverflow overflow = TextOverflow.ellipsis,
  bool softWrap = false,
  int maxLines = 4,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color(AppColor.error),
      fontWeight: weight,
      height: height,
    ),
    textAlign: align,
    softWrap: softWrap,
    overflow: overflow,
    maxLines: maxLines,
  );
}
