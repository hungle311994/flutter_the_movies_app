import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/common/dialog.dart';
import 'package:the_movie_app/common/media_type.dart';
import 'package:the_movie_app/common/string.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/components/image_item.dart';
import 'package:the_movie_app/models/movie/movie.dart';
import 'package:the_movie_app/providers/movie_provider.dart';
import 'package:the_movie_app/providers/wish_list_provider.dart';
import 'package:the_movie_app/views/movie/movie_detail_page.dart';

class MovieRow extends StatefulHookWidget {
  const MovieRow({
    Key? key,
    required this.title,
    required this.movies,
    this.isFromDetail = false,
  }) : super(key: key);

  final String title;
  final List<Movie> movies;
  final bool isFromDetail;

  @override
  _MovieRowState createState() => _MovieRowState();
}

class _MovieRowState extends State<MovieRow> {
  @override
  Widget build(BuildContext context) {
    final _movies = widget.movies;
    final _movieWishList = useProvider(movieWishListProvider);

    return Container(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          whiteTxt(
            text: widget.title,
            size: 18,
            weight: FontWeight.bold,
          ),
          hSpace(10),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final _movieAdded = _movieWishList.firstWhere(
                  (item) => item.id == _movies[index].id,
                  orElse: () => Movie(id: null),
                );
                return _card(
                  id: _movies[index].id ?? 0,
                  path: _movies[index].posterPath,
                  mediaType: _movies[index].mediaType ?? MediaTypeEnum.movie,
                  movieAdded: _movieAdded,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({
    required MediaTypeEnum mediaType,
    required int id,
    String? path,
    Movie? movieAdded,
  }) {
    return Container(
      width: 140,
      margin: marginRight2,
      child: GestureDetector(
        onTap: () async {
          await EasyLoading.show(maskType: EasyLoadingMaskType.black);
          final _result = await context
              .read(movieDetailProvider.notifier)
              .getMovieDetail(id);

          if (widget.isFromDetail == true) {
            Navigator.pop(context);
          }

          if (_result) {
            final _isBack = await Navigator.push<bool>(
              context,
              PageTransition(
                child: MovieDetailPage(id: id),
                type: PageTransitionType.rightToLeft,
              ),
            );

            if (_isBack == true) {
              setState(() {});
            }
          } else {
            await EasyLoading.dismiss();
            await showErrorDlg(
              title: errorMessageSomethingHappened,
              context: context,
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ImageItem(path: path),
                  if (movieAdded?.id != null) ...[
                    Container(
                      decoration: BoxDecoration(
                        gradient: gradientColorBlurTop,
                      ),
                      child: SizedBox(width: 140, height: 35),
                    ),
                    Icon(
                      Icons.bookmark,
                      color: color(AppColor.primary),
                      size: 30,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
