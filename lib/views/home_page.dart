import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/components/rows/movie_row.dart';
import 'package:the_movie_app/components/rows/tv_row.dart';
import 'package:the_movie_app/providers/movie_provider.dart';
import 'package:the_movie_app/providers/tv_provider.dart';

class HomePage extends StatefulHookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final _trendingMovies = useProvider(trendingMovieProvider);
    final _topRatedMovies = useProvider(topRatedMovieProvider);
    final _trendingTVs = useProvider(trendingTVProvider);
    final _topRatedTVs = useProvider(topRatedTVProvider);

    return Padding(
      padding: padding2,
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        strokeWidth: 2,
        child: !_isLoading
            ? ListView(
                children: [
                  MovieRow(title: 'Trending Movies', movies: _trendingMovies),
                  hSpace(30),
                  MovieRow(title: 'Top Rated Movies', movies: _topRatedMovies),
                  hSpace(30),
                  TVRow(title: 'Trending TVs', tvs: _trendingTVs),
                  hSpace(30),
                  TVRow(title: 'Top Rated TVs', tvs: _topRatedTVs),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await _fetchTrendingData();
  }

  Future<void> _fetchTrendingData() async {
    setState(() {
      _isLoading = true;
    });

    await context.read(trendingMovieProvider.notifier).getTrendingMovies();
    await context.read(topRatedMovieProvider.notifier).getTopRatedMovies();
    await context.read(trendingTVProvider.notifier).getTrendingTVs();
    await context.read(topRatedTVProvider.notifier).getTopRatedTVs();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await _fetchTrendingData();
      await EasyLoading.dismiss();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
