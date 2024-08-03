import 'package:flutter/material.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/components/image_item.dart';
import 'package:the_movie_app/models/cast/cast.dart';

class CastSlider extends StatelessWidget {
  const CastSlider({
    Key? key,
    required this.casts,
  }) : super(key: key);

  final List<Cast> casts;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          whiteTxt(
            text: 'Cast',
            size: 18,
            weight: FontWeight.bold,
          ),
          hSpace(10),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: casts.length,
              itemBuilder: (context, index) {
                return _cast(cast: casts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _cast({required Cast cast}) {
    return Container(
      width: 75,
      height: 75,
      margin: marginRight2,
      child: Column(
        children: [
          ImageItem(
            path: cast.profilePath,
            width: 75,
            height: 75,
            fit: BoxFit.contain,
            borderRadius: 100,
          ),
          Container(
            width: 75,
            child: whiteTxt(
              text: cast.name ?? '',
              align: TextAlign.center,
              size: 13,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
