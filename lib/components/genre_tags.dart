import 'package:flutter/material.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/models/genre/genre.dart';

class GenreTags extends StatelessWidget {
  const GenreTags({
    Key? key,
    required this.genres,
  }) : super(key: key);

  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width - 95,
      child: Wrap(
        runSpacing: 6,
        spacing: 6,
        children: [
          ...genres.map((genre) => genreTag(genre)).toList(),
        ],
      ),
    );
  }

  Widget genreTag(Genre genre) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color(AppColor.darkGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: whiteTxt(
        text: genre.name ?? '',
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        size: 13,
      ),
    );
  }
}
