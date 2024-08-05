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
import 'package:the_movie_app/models/movie/movie.dart';
import 'package:the_movie_app/providers/movie_provider.dart';
import 'package:the_movie_app/providers/wish_list_provider.dart';
import 'package:the_movie_app/views/movie/movie_detail_page.dart';

class MoviePage extends StatefulHookWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  int _pn = 1;
  bool _isLoading = false;
  bool _isSearch = false;
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final _movies = useProvider(popularMovieProvider);
    final _movieWishList = useProvider(movieWishListProvider);
    final _searchedMovies = _searchText.isNotEmpty
        ? _movies
            .where((movie) =>
                (movie.originalTitle ?? '')
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()) ||
                (movie.originalName ?? '')
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()))
            .toList()
        : _movies;

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
                          text: 'Movies',
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
                          _searchedMovies.length >= 10 &&
                          scrollInfo.metrics.pixels >
                              scrollInfo.metrics.maxScrollExtent - 200) {
                        setState(() {
                          _isLoading = true;
                        });
                        _fetchPopularMovies();
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
                        itemCount: _searchedMovies.length,
                        itemBuilder: (context, index) {
                          final _movieAdded = _movieWishList.firstWhere(
                            (item) => item.id == _movies[index].id,
                            orElse: () => Movie(id: null),
                          );
                          return _card(
                            movie: _searchedMovies[index],
                            movieAdded: _movieAdded,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          spinnerLoadmore(isLoading: _isLoading),
        ],
      ),
    );
  }

  Widget _card({required Movie movie, Movie? movieAdded}) {
    return GestureDetector(
      onTap: () async {
        await _onTapMovie(movie);
      },
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                ImageItem(
                  height: 200,
                  borderRadius: 10,
                  path: movie.posterPath,
                ),
                if (movieAdded?.id != null) ...[
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
              text: movie.originalTitle ?? '',
              maxLines: 1,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapMovie(Movie movie) async {
    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
    final _result = await context
        .read(movieDetailProvider.notifier)
        .getMovieDetail(movie.id ?? 0);

    if (_result) {
      final _isBack = await Navigator.push<bool>(
        context,
        PageTransition(
          child: MovieDetailPage(id: movie.id ?? 0),
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

  Future<void> _fetchPopularMovies() async {
    if (_pn != 1) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }

    final _result =
        await context.read(popularMovieProvider.notifier).getPopularMovies(_pn);

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
    context.read(popularMovieProvider.notifier).clear();
    setState(() {});
    await _fetchPopularMovies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await _fetchPopularMovies();
      await EasyLoading.dismiss();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
