import 'package:flutter/material.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/common/text.dart';

class VoteCount extends StatelessWidget {
  VoteCount({
    Key? key,
    required this.animation,
    this.popularity,
    this.voteCount,
  }) : super(key: key);

  final Animation<double> animation;
  double? popularity;
  int? voteCount;

  @override
  Widget build(BuildContext context) {
    final _progressValue = animation.value * 10;

    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Text(
              roundedNumber(_progressValue).toString(),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                fontSize: 14,
                color: _progressColor(_progressValue),
              ),
            ),
            CircularProgressIndicator(
              color: _progressColor(_progressValue),
              backgroundColor: color(AppColor.darkGrey),
              value: animation.value,
            ),
          ],
        ),
        wSpace(10),
        Container(
          width: 1,
          height: 35,
          decoration: BoxDecoration(
            color: color(AppColor.noImageBackground),
          ),
        ),
        wSpace(10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                whiteTxt(
                  text: (popularity ?? 0).round().toString(),
                  size: 14,
                ),
                wSpace(5),
                brightGreyTxt(text: 'ratings'),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                whiteTxt(
                  text: (voteCount ?? 0).round().toString(),
                  size: 14,
                ),
                wSpace(5),
                brightGreyTxt(text: 'reviews'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Color _progressColor(double value) {
    if (0 < value && value <= 2.5) {
      return color(AppColor.error);
    }

    if (2.5 <= value && value <= 5.0) {
      return color(AppColor.lightYellow);
    }

    if (5.0 <= value && value <= 7.5) {
      return color(AppColor.lightGreen);
    }

    if (7.5 <= value && value <= 10.0) {
      return color(AppColor.primary);
    }

    return color(AppColor.darkGrey);
  }
}
