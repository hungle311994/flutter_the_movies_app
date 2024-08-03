import 'package:flutter/material.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/components/image_item.dart';
import 'package:the_movie_app/models/season/season.dart';

class TVSeasonPage extends StatelessWidget {
  const TVSeasonPage({
    Key? key,
    required this.season,
  }) : super(key: key);

  final Season season;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: color(AppColor.background),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ImageItem(
        width: _width,
        height: _height - 300,
        fit: BoxFit.fill,
        path: season.posterPath,
      ),
    );
  }
}
