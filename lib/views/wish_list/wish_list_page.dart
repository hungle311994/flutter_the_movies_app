import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/common/dialog.dart';
import 'package:the_movie_app/common/string.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/components/genre_tags.dart';
import 'package:the_movie_app/components/image_item.dart';
import 'package:the_movie_app/models/movie/movie.dart';
import 'package:the_movie_app/models/tv/tv.dart';
import 'package:the_movie_app/providers/wish_list_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class WishListPage extends StatefulHookWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  int _tabIndex = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _movieWishList = useProvider(movieWishListProvider);
    final _tvWishList = useProvider(tvWishListProvider);

    return Padding(
      padding: padding2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(
                        height: 35,
                        child: ToggleSwitch(
                          minWidth: 90.0,
                          cornerRadius: 20.0,
                          activeBgColors: [
                            [color(AppColor.white)],
                            [color(AppColor.white)]
                          ],
                          activeFgColor: color(AppColor.darkerGrey),
                          inactiveBgColor: color(AppColor.darkerGrey),
                          inactiveFgColor: color(AppColor.white),
                          initialLabelIndex: _tabIndex,
                          totalSwitches: 2,
                          labels: [movies, tvShows],
                          radiusStyle: true,
                          onToggle: (index) async {
                            if (_tabIndex == index) {
                              return;
                            }
                            await EasyLoading.show(
                                maskType: EasyLoadingMaskType.black);
                            setState(() {
                              _tabIndex = index!;
                            });
                            await EasyLoading.dismiss();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(15),
                Expanded(
                  child: _wishListView(
                    movieWishList: _movieWishList,
                    tvWishList: _tvWishList,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: _isLoading ? height[2] : height[0],
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: color(AppColor.darkGrey),
                backgroundColor: color(AppColor.outlineBorderGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _wishListView({
    required List<Movie> movieWishList,
    required List<TV> tvWishList,
  }) {
    return Container(
      child: _tabIndex == 0
          ? _movieWishListView(wishList: movieWishList)
          : _tvWishListView(wishList: tvWishList),
    );
  }

  Widget _movieWishListView({required List<Movie> wishList}) {
    return wishList.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: wishList.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  extentRatio: 0.2,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      autoClose: true,
                      onPressed: (value) async {
                        await _onRemoveMovie(movie: wishList[index]);
                      },
                      backgroundColor: color(AppColor.background),
                      foregroundColor: color(AppColor.error),
                      icon: Icons.delete,
                    ),
                  ],
                ),
                child: _cardMovieWishList(wishList[index]),
              );
            },
          )
        : Center(child: whiteTxt(text: noMovieAvailable));
  }

  Widget _cardMovieWishList(Movie? movie) {
    final _width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          width: _width - 30,
          padding: padding0,
          margin: marginBottom2,
          decoration: BoxDecoration(
            color: color(AppColor.darkerGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Card(
            elevation: 0,
            color: color(AppColor.darkerGrey),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageItem(
                  width: 80,
                  height: 80,
                  borderRadius: 8,
                  path: movie?.posterPath,
                ),
                wSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      whiteTxt(
                        text: movie?.originalTitle ?? movie?.originalName ?? '',
                        weight: FontWeight.bold,
                        softWrap: true,
                        maxLines: 1,
                        size: 14,
                      ),
                      hSpace(5),
                      if (movie != null &&
                          movie.genres != null &&
                          movie.genres!.isNotEmpty) ...[
                        Wrap(
                          runSpacing: 3,
                          spacing: 3,
                          children: [
                            GenreTags(genres: movie.genres!),
                          ],
                        ),
                        hSpace(5),
                      ],
                      brightGreyTxt(
                        text: '${movie?.releaseDate ?? ''} (${movie?.status})',
                        softWrap: true,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _tvWishListView({required List<TV> wishList}) {
    return wishList.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: wishList.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  extentRatio: 0.2,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      autoClose: true,
                      onPressed: (value) async {
                        await _onRemoveTV(tv: wishList[index]);
                      },
                      backgroundColor: color(AppColor.background),
                      foregroundColor: color(AppColor.error),
                      icon: Icons.delete,
                    ),
                  ],
                ),
                child: _cardTVWishList(wishList[index]),
              );
            },
          )
        : Center(child: whiteTxt(text: noTVAvailable));
  }

  Widget _cardTVWishList(TV? tv) {
    final _width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          width: _width - 30,
          padding: padding0,
          margin: marginBottom2,
          decoration: BoxDecoration(
            color: color(AppColor.darkerGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Card(
            elevation: 0,
            color: color(AppColor.darkerGrey),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageItem(
                  width: 80,
                  height: 80,
                  borderRadius: 8,
                  path: tv?.posterPath,
                ),
                wSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      whiteTxt(
                        text: tv?.originalTitle ?? tv?.originalName ?? '',
                        weight: FontWeight.bold,
                        softWrap: true,
                        maxLines: 1,
                        size: 14,
                      ),
                      hSpace(5),
                      if (tv != null &&
                          tv.genres != null &&
                          tv.genres!.isNotEmpty) ...[
                        Wrap(
                          runSpacing: 3,
                          spacing: 3,
                          children: [
                            GenreTags(genres: tv.genres!),
                          ],
                        ),
                        hSpace(5),
                      ],
                      brightGreyTxt(
                        text: '${tv?.status}',
                        softWrap: true,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> _onRemoveMovie({required Movie movie}) async {
    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
    final _result = await context
        .read(movieWishListProvider.notifier)
        .removeWishList(movie);
    await EasyLoading.dismiss();

    if (_result == true) {
      setState(() {});
      await showBottomToastSuccess(
        msg: messageRemovedSuccess(getStringType(movie.mediaType)),
      );
    } else {
      await showBottomToastError(msg: errorMessageSomethingHappened);
    }
  }

  Future<void> _onRemoveTV({required TV tv}) async {
    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
    final _result =
        await context.read(tvWishListProvider.notifier).removeWishList(tv);
    await EasyLoading.dismiss();

    if (_result == true) {
      setState(() {});
      await showBottomToastSuccess(
        msg: messageRemovedSuccess(getStringType(tv.mediaType)),
      );
    } else {
      await showBottomToastError(msg: errorMessageSomethingHappened);
    }
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
