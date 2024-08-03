import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/common/dialog.dart';
import 'package:the_movie_app/common/media_type.dart';
import 'package:the_movie_app/common/string.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/components/cast_slider.dart';
import 'package:the_movie_app/components/genre_tags.dart';
import 'package:the_movie_app/components/image_item.dart';
import 'package:the_movie_app/components/rows/movie_row.dart';
import 'package:the_movie_app/components/video_player.dart';
import 'package:the_movie_app/models/movie/movie.dart';
import 'package:the_movie_app/models/video/video.dart';
import 'package:the_movie_app/providers/cast_provider.dart';
import 'package:the_movie_app/providers/movie_provider.dart';
import 'package:the_movie_app/providers/video_provider.dart';
import 'package:the_movie_app/providers/wish_list_provider.dart';

class MovieDetailPage extends StatefulHookWidget {
  const MovieDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    final _movie = useProvider(movieDetailProvider);
    final _casts = useProvider(castProvider);
    final _videos = useProvider(videoProvider);
    final _similarMovies = useProvider(similarMovieProvider);
    final _movieWishList = useProvider(movieWishListProvider);
    final _isWishLishAdded = _movieWishList.contains(_movie);

    _animation = Tween<double>(
      begin: (_movie?.voteAverage ?? 0) / 10,
      end: (_movie?.voteAverage ?? 0) / 10,
    ).animate(_controller);

    return Scaffold(
      backgroundColor: color(AppColor.background),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: SliverAppBar(
                  floating: true,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  forceElevated: innerBoxIsScrolled,
                  titleSpacing: 0,
                  title: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        arrowBackIcon(
                          context: context,
                          platform: defaultTargetPlatform,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _handleMovieToWishList(
                              isWishLishAdded: _isWishLishAdded,
                              movie: _movie,
                            );
                          },
                          child: Icon(
                            _isWishLishAdded
                                ? Icons.bookmark_remove
                                : Icons.bookmark_add_outlined,
                            color: color(AppColor.white),
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            children: [
              _poster(_movie),
              hSpace(20),
              Padding(
                padding: paddingHorizontal2,
                child: Column(
                  children: [
                    _voteCount(_movie),
                    hSpace(30),
                    _discription(_movie),
                    hSpace(30),
                    _detail(_movie),
                    if (_casts.isNotEmpty) ...[
                      hSpace(30),
                      CastSlider(casts: _casts),
                    ],
                    if (_videos.isNotEmpty) ...[
                      hSpace(30),
                      _trailer(_videos),
                    ],
                    if (_similarMovies.isNotEmpty) ...[
                      hSpace(30),
                      MovieRow(
                        title: 'You might also like',
                        movies: _similarMovies,
                        isFromDetail: true,
                      ),
                    ],
                    hSpace(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _poster(Movie? movie) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Stack(
        children: [
          ImageItem(
            width: _width,
            height: 300,
            fit: BoxFit.fill,
            path: movie?.backdropPath,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: gradientColorBlurBottom,
            ),
            child: SizedBox(width: _width, height: 305),
          ),
          Positioned(
            top: 95,
            bottom: -95,
            child: Container(
              padding: padding2,
              width: _width,
              child: Row(
                children: [
                  ImageItem(
                    path: movie?.posterPath,
                    width: 150,
                    height: 200,
                  ),
                  wSpace(20),
                  Container(
                    width: _width - 200,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        whiteTxt(
                          text: movie?.title ?? '',
                          weight: FontWeight.bold,
                          size: 20,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                        hSpace(10),
                        brightGreyTxt(
                          text: 'Original title: ${movie?.title ?? ''}',
                          weight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          size: 15,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _voteCount(Movie? movie) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            mainTxt(
              text: roundedNumber(_animation.value * 10).toString(),
              size: 14,
            ),
            CircularProgressIndicator(
              color: color(AppColor.primary),
              backgroundColor: color(AppColor.darkGrey),
              value: _animation.value,
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
                  text: (movie?.popularity ?? 0).round().toString(),
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
                  text: (movie?.voteCount ?? 0).round().toString(),
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

  Widget _discription(Movie? movie) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          whiteTxt(
            text: 'Discription',
            size: 18,
            weight: FontWeight.bold,
          ),
          hSpace(7),
          brightGreyTxt(text: movie?.overview ?? ''),
          brightGreyTxt(text: movie?.tagline ?? ''),
        ],
      ),
    );
  }

  Widget _detail(Movie? movie) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          whiteTxt(
            text: 'Details',
            size: 18,
            weight: FontWeight.bold,
          ),
          hSpace(7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whiteTxt(text: 'Genres: ', size: 14),
              if (movie != null && movie.genres != null) ...[
                wSpace(10),
                GenreTags(genres: movie.genres!),
              ],
            ],
          ),
          hSpace(7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              whiteTxt(text: 'Runtime: ', size: 14),
              if (movie != null && movie.runtime != null) ...[
                wSpace(10),
                whiteTxt(
                  text: '${movie.runtime.toString()} min',
                  size: 12,
                ),
              ],
            ],
          ),
          hSpace(7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              whiteTxt(text: 'Release Date: ', size: 14),
              if (movie != null && movie.releaseDate != null) ...[
                wSpace(10),
                whiteTxt(
                  text: '${movie.releaseDate} (${movie.status ?? ''})',
                  size: 12,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _trailer(List<Video> videos) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          whiteTxt(
            text: 'Trailer',
            size: 18,
            weight: FontWeight.bold,
          ),
          hSpace(7),
          VideoPlayer(videos: videos),
        ],
      ),
    );
  }

  Future<void> _handleMovieToWishList({
    required bool isWishLishAdded,
    Movie? movie,
  }) async {
    if (isWishLishAdded) {
      final _result = await context
          .read(movieWishListProvider.notifier)
          .removeWishList(movie);

      if (_result == true) {
        setState(() {});
        await showBottomToastSuccess(msg: 'Removed movie from wish list!');
      } else {
        await showBottomToastError(msg: errorMessageSomethingHappened);
      }
    } else {
      final _result =
          await context.read(movieWishListProvider.notifier).addWishList(movie);

      if (_result == true) {
        setState(() {});
        await showBottomToastSuccess(msg: 'Added movie to wish list!');
      } else {
        await showBottomToastError(msg: errorMessageSomethingHappened);
      }
    }
  }

  Future<void> _fetchData(int id) async {
    await context.read(castProvider.notifier).getCasts(MediaTypeEnum.movie, id);
    await context
        .read(videoProvider.notifier)
        .getVideos(MediaTypeEnum.movie, id);
    await context.read(similarMovieProvider.notifier).getSimilarMovies(id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await _fetchData(widget.id);
      await EasyLoading.dismiss();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
