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
import 'package:the_movie_app/common/string.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/components/image_item.dart';
import 'package:the_movie_app/components/search_box.dart';
import 'package:the_movie_app/models/tv/tv.dart';
import 'package:the_movie_app/providers/tv_provider.dart';
import 'package:the_movie_app/providers/wish_list_provider.dart';
import 'package:the_movie_app/views/tv/tv_detail.page.dart';

class TVPage extends StatefulHookWidget {
  const TVPage({Key? key}) : super(key: key);

  @override
  _TVPageState createState() => _TVPageState();
}

class _TVPageState extends State<TVPage> {
  int _pn = 1;
  bool _isLoading = false;
  bool _isSearch = false;
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final _tvs = useProvider(popularTVProvider);
    final _tvWishList = useProvider(tvWishListProvider);
    final _searchedTVs = _searchText.isNotEmpty
        ? _tvs
            .where((tv) =>
                (tv.originalTitle ?? '')
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()) ||
                (tv.originalName ?? '')
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()))
            .toList()
        : _tvs;

    return Padding(
      padding: padding2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!_isSearch)
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        whiteTxt(
                          text: 'TV shows',
                          size: 20,
                          weight: FontWeight.bold,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSearch = true;
                            });
                          },
                          child: Icon(
                            Icons.search,
                            size: 30,
                            color: color(AppColor.white),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  SearchBox(
                    onOpenSearch: (bool open) {
                      setState(() {
                        _isSearch = open;
                      });
                    },
                    onChanged: (String value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                  ),
                hSpace(20),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!_isLoading &&
                          _searchedTVs.length >= 10 &&
                          scrollInfo.metrics.pixels >
                              scrollInfo.metrics.maxScrollExtent - 200) {
                        setState(() {
                          _isLoading = true;
                        });
                        _fetchPopularTVs();
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      strokeWidth: 2,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: _searchedTVs.length,
                        itemBuilder: (context, index) {
                          final _tvAdded = _tvWishList.firstWhere(
                            (item) => item.id == _tvs[index].id,
                            orElse: () => TV(id: null),
                          );
                          return _card(
                            tv: _searchedTVs[index],
                            tvAdded: _tvAdded,
                          );
                        },
                      ),
                    ),
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

  Widget _card({required TV tv, TV? tvAdded}) {
    return GestureDetector(
      onTap: () async {
        await _onTapTV(tv);
      },
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                ImageItem(
                  height: 200,
                  borderRadius: 10,
                  path: tv.posterPath,
                ),
                if (tvAdded?.id != null) ...[
                  Container(
                    decoration: BoxDecoration(
                      gradient: gradientColorBlurTop,
                    ),
                    child: SizedBox(width: 200, height: 35),
                  ),
                  Icon(
                    Icons.bookmark,
                    color: color(AppColor.primary),
                    size: 30,
                  ),
                ],
              ],
            ),
            whiteTxt(
              text: tv.originalName ?? '',
              maxLines: 1,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapTV(TV tv) async {
    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
    final _result =
        await context.read(tvDetailProvider.notifier).getTVDetail(tv.id ?? 0);

    if (_result) {
      final _isBack = await Navigator.push<bool>(
        context,
        PageTransition(
          child: TVDetailPage(id: tv.id ?? 0),
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
  }

  Future<void> _fetchPopularTVs() async {
    if (_pn != 1) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }

    final _result =
        await context.read(popularTVProvider.notifier).getPopularTVs(_pn);

    if (_result == true) {
      _isLoading = false;
      _pn++;
      setState(() {});
    } else {
      await showErrorDlg(
        context: context,
        title: errorMessageSomethingHappened,
      );
    }
  }

  Future<void> _onRefresh() async {
    _pn = 1;
    context.read(popularTVProvider.notifier).clear();
    setState(() {});
    await _fetchPopularTVs();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await _fetchPopularTVs();
      await EasyLoading.dismiss();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
