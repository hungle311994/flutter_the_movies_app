import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/common/string.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/services/account_service.dart';
import 'package:the_movie_app/utils/shared_pref.dart';

SimpleDialog _autoClosedErrorDlg({
  required String content,
  required BuildContext context,
}) {
  return SimpleDialog(
    titlePadding: padding4,
    contentPadding: padding3,
    insetPadding: paddingHorizontal2,
    title: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: defaultTxt(
          text: content,
          size: 16,
          align: TextAlign.center,
        ),
      ),
    ),
  );
}

Future<void> showErrorDlg({
  required String title,
  required BuildContext context,
}) async {
  final timer = Timer(const Duration(seconds: 3), () {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  });

  await showDialog<void>(
    context: context,
    barrierColor: barrierColor,
    barrierDismissible: true,
    builder: (_) => _autoClosedErrorDlg(
      content: title,
      context: context,
    ),
  );

  timer.cancel();
}

SimpleDialog logoutConfirmDlg(BuildContext context) {
  final _pref = SharedPref();

  return SimpleDialog(
    contentPadding: padding3,
    insetPadding: padding3,
    backgroundColor: color(AppColor.darkestGrey),
    children: [
      hSpace(20),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: brightGreyTxt(
            text: messageConfirmLogout,
            size: 16,
          ),
        ),
      ),
      hSpace(30),
      Padding(
        padding: paddingHorizontal2,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 46,
                child: TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      side: BorderSide(
                        color: color(AppColor.darkGrey),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: brightGreyTxt(text: cancelBtn, size: 15),
                ),
              ),
            ),
            wSpace(10),
            Expanded(
              child: SizedBox(
                height: 46,
                child: TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      side: BorderSide(
                        color: color(AppColor.error),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final _response = await AccountService().logout();

                    if (_response.containsKey('result')) {
                      final _result = _response['result'] as bool;
                      final _msg = _response['message'] as String?;

                      if (_result == true) {
                        await _pref.setIsLogin(false);
                        await navToLoginPage(context: context);
                      } else {
                        await showBottomToastError(msg: _msg ?? '');
                      }
                    } else {
                      await showBottomToastError(
                        msg: errorMessageSomethingHappened,
                      );
                    }
                  },
                  child: errorTxt(text: logoutBtn, size: 15),
                ),
              ),
            ),
          ],
        ),
      ),
      hSpace(20),
    ],
  );
}

Future<void> showCenterToastSuccess({
  required String msg,
  int time = 3,
}) async {
  await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: successToastColor,
    textColor: Colors.white,
    timeInSecForIosWeb: time,
  );
}

Future<void> showBottomToastSuccess({
  required String msg,
  int time = 3,
}) async {
  await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: successToastColor,
    textColor: Colors.white,
    timeInSecForIosWeb: time,
  );
}

Future<void> showCenterToastError({
  required String msg,
  int time = 3,
}) async {
  await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: errorToastColor,
    textColor: Colors.white,
    timeInSecForIosWeb: time,
  );
}

Future<void> showBottomToastError({
  required String msg,
  int time = 3,
}) async {
  await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: errorToastColor,
    textColor: Colors.white,
    timeInSecForIosWeb: time,
  );
}
