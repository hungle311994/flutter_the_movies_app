import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/media_type.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/views/login/login_page.dart';
import 'package:the_movie_app/views/register/register_page.dart';
import 'package:the_movie_app/views/route_page.dart';
import 'package:the_movie_app/views/settings/settings_page.dart';

const String emailRegex =
    r"^([-!#-'*+/-9=?A-Z^-~]+(\.([-!#-'*+/-9=?A-Z^-~]+|'([!#-\[\]-~]|\\[\x00-~])+'))*|'([!#-\[\]-~]|\\[\x00-~])+')@([-!#-'*+/-9=?A-Z^-~]+(\.[-!#-'*+/-9=?A-Z^-~]+)*)$";

void unFocusScope(BuildContext context) => FocusScope.of(context).unfocus();

Widget appTitle() {
  return Row(
    children: [
      Image.asset(
        'assets/images/logo.png',
        height: 35,
      ),
      wSpace(15),
      GradientText(
        'The Movies',
        style: const TextStyle(fontSize: 25),
        gradient: gradientColor,
      ),
    ],
  );
}

Widget arrowBackIcon({
  required BuildContext context,
  required TargetPlatform platform,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context, true);
    },
    child: platform == TargetPlatform.android
        ? const Icon(Icons.arrow_back, size: 30, color: Colors.white)
        : const Icon(Icons.arrow_back_ios_new, size: 30, color: Colors.white),
  );
}

Widget spinnerLoadmore({
  required bool isLoading,
}) {
  return SizedBox(
    height: isLoading ? height[2] : height[0],
    child: Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color(AppColor.darkGrey),
        backgroundColor: color(AppColor.outlineBorderGrey),
      ),
    ),
  );
}

Widget label(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: whiteTxt(
      text: text,
      size: 12,
    ),
  );
}

SizedBox hSpace(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox wSpace(double width) {
  return SizedBox(
    width: width,
  );
}

double roundedNumber(double number) {
  return double.parse(number.toStringAsFixed(1));
}

Future<void> navToLoginPage({
  required BuildContext context,
}) async {
  await Navigator.pushAndRemoveUntil(
    context,
    PageTransition(
      child: const LoginPage(),
      type: PageTransitionType.fade,
    ),
    (route) => false,
  );
}

Future<void> navToRegisterPage({
  required BuildContext context,
}) async {
  await Navigator.pushAndRemoveUntil(
    context,
    PageTransition(
      child: const RegisterLoginPage(),
      type: PageTransitionType.fade,
    ),
    (route) => false,
  );
}

Future<void> navToRoutePage({
  required BuildContext context,
}) async {
  await Navigator.pushAndRemoveUntil(
    context,
    PageTransition(
      child: const RoutePage(),
      type: PageTransitionType.fade,
    ),
    (route) => false,
  );
}

Future<void> navToAccountPage({
  required BuildContext context,
}) async {
  await Navigator.push<void>(
    context,
    PageTransition(
      child: SettingsPage(),
      type: PageTransitionType.rightToLeft,
    ),
  );
}

String getStringType(MediaTypeEnum? mediaType) {
  switch (mediaType) {
    case MediaTypeEnum.movie:
      return 'movie';
    case MediaTypeEnum.tv:
      return 'tv';
    default:
      return '';
  }
}

OutlineInputBorder greyBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide(color: Colors.grey),
);

OutlineInputBorder noBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide.none,
);

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
