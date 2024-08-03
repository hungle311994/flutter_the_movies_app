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
import 'package:the_movie_app/components/rows/tv_row.dart';
import 'package:the_movie_app/components/video_player.dart';
import 'package:the_movie_app/models/season/season.dart';
import 'package:the_movie_app/models/tv/tv.dart';
import 'package:the_movie_app/models/video/video.dart';
import 'package:the_movie_app/providers/cast_provider.dart';
import 'package:the_movie_app/providers/tv_provider.dart';
import 'package:the_movie_app/providers/video_provider.dart';
import 'package:the_movie_app/providers/wish_list_provider.dart';
import 'package:the_movie_app/views/tv/tv_season_page.dart';

class TVDetailPage extends StatefulHookWidget {
  const TVDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<TVDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    final _tv = useProvider(tvDetailProvider);
    final _casts = useProvider(castProvider);
    final _videos = useProvider(videoProvider);
    final _similarTVs = useProvider(similarTVProvider);
    final _tvWishList = useProvider(tvWishListProvider);
    final _isWishLishAdded = _tvWishList.contains(_tv);

    _animation = Tween<double>(
      begin: (_tv?.voteAverage ?? 0) / 10,
      end: (_tv?.voteAverage ?? 0) / 10,
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
                            await _handleTVToWishList(
                              isWishLishAdded: _isWishLishAdded,
                              tv: _tv,
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
              _poster(_tv),
              hSpace(20),
              Padding(
                padding: paddingHorizontal2,
                child: Column(
                  children: [
                    _voteCount(_tv),
                    hSpace(30),
                    _discription(_tv),
                    hSpace(30),
                    _detail(_tv),
                    if (_casts.isNotEmpty) ...[
                      hSpace(30),
                      CastSlider(casts: _casts),
                    ],
                    if (_tv != null &&
                        _tv.seasons != null &&
                        _tv.seasons!.isNotEmpty) ...[
                      hSpace(30),
                      _seasonList(_tv),
                    ],
                    if (_videos.isNotEmpty) ...[
                      hSpace(30),
                      _trailer(_videos),
                    ],
                    if (_similarTVs.isNotEmpty) ...[
                      hSpace(30),
                      TVRow(
                        title: 'You might also like',
                        tvs: _similarTVs,
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

  Widget _poster(TV? tv) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Stack(
        children: [
          ImageItem(
            width: _width,
            height: 300,
            fit: BoxFit.fill,
            path: tv?.backdropPath,
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
                    path: tv?.posterPath,
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
                          text: tv?.name ?? '',
                          weight: FontWeight.bold,
                          size: 20,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                        hSpace(10),
                        brightGreyTxt(
                          text: 'Original title: ${tv?.originalName ?? ''}',
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

  Widget _voteCount(TV? tv) {
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
                  text: (tv?.popularity ?? 0).round().toString(),
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
                  text: (tv?.voteCount ?? 0).round().toString(),
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

  Widget _discription(TV? tv) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          whiteTxt(
            text: 'Discription',
            size: 16,
            weight: FontWeight.bold,
          ),
          hSpace(7),
          brightGreyTxt(text: tv?.overview ?? ''),
          brightGreyTxt(text: tv?.tagline ?? ''),
        ],
      ),
    );
  }

  Widget _detail(TV? tv) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          whiteTxt(
            text: 'Details',
            size: 16,
            weight: FontWeight.bold,
          ),
          hSpace(7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whiteTxt(text: 'Genres: ', size: 14),
              if (tv != null && tv.genres != null) ...[
                wSpace(10),
                GenreTags(genres: tv.genres!),
              ],
            ],
          ),
          hSpace(7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              whiteTxt(text: 'Episodes: ', size: 14),
              if (tv != null && tv.numberOfEpisodes != null) ...[
                wSpace(10),
                whiteTxt(
                  text: '${tv.numberOfEpisodes.toString()} min',
                  size: 12,
                ),
              ],
            ],
          ),
          hSpace(7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              whiteTxt(text: 'Last Air Date: ', size: 14),
              if (tv != null && tv.lastAirDate != null) ...[
                wSpace(10),
                whiteTxt(
                  text: '${tv.lastAirDate} (${tv.status ?? ''})',
                  size: 12,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _seasonList(TV tv) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          whiteTxt(
            text: 'Seasons',
            size: 18,
            weight: FontWeight.bold,
          ),
          hSpace(7),
          Wrap(
            runSpacing: 6,
            spacing: 6,
            children: [
              ...tv.seasons!.map((season) => _seasonItem(season)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _seasonItem(Season season) {
    return GestureDetector(
      onTap: () async {
        _onTapSeason(season);
      },
      child: Container(
        child: Column(
          children: [
            ImageItem(
              width: 75,
              height: 100,
              borderRadius: 8,
              path: season.posterPath,
            ),
            whiteTxt(
              text: season.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            )
          ],
        ),
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
            size: 16,
            weight: FontWeight.bold,
          ),
          hSpace(7),
          VideoPlayer(videos: videos),
        ],
      ),
    );
  }

  Future<void> _onTapSeason(Season season) async {
    await showDialog<void>(
      context: context,
      barrierColor: barrierColor,
      barrierDismissible: true,
      builder: (_) => TVSeasonPage(season: season),
    );
  }

  Future<void> _handleTVToWishList({
    required bool isWishLishAdded,
    TV? tv,
  }) async {
    if (isWishLishAdded) {
      final _result =
          await context.read(tvWishListProvider.notifier).removeWishList(tv);

      if (_result == true) {
        setState(() {});
        await showBottomToastSuccess(msg: 'Removed tv from wish list!');
      } else {
        await showBottomToastError(msg: errorMessageSomethingHappened);
      }
    } else {
      final _result =
          await context.read(tvWishListProvider.notifier).addWishList(tv);

      if (_result == true) {
        setState(() {});
        await showBottomToastSuccess(msg: 'Added tv to wish list!');
      } else {
        await showBottomToastError(msg: errorMessageSomethingHappened);
      }
    }
  }

  Future<void> _fetchData(int id) async {
    await context.read(castProvider.notifier).getCasts(MediaTypeEnum.tv, id);
    await context.read(videoProvider.notifier).getVideos(MediaTypeEnum.tv, id);
    await context.read(similarTVProvider.notifier).getSimilarTVs(id);
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
