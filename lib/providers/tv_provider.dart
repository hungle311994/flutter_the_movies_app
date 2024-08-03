import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_movie_app/models/tv/tv.dart';
import 'package:the_movie_app/services/tv_service.dart';

final _tvService = TVService();
final trendingTVProvider = StateNotifierProvider<TrendingTVState, List<TV>>(
    (ref) => TrendingTVState());
final topRatedTVProvider = StateNotifierProvider<TopRatedTVState, List<TV>>(
    (ref) => TopRatedTVState());
final similarTVProvider = StateNotifierProvider<SimilarMovieState, List<TV>>(
    (ref) => SimilarMovieState());
final popularTVProvider =
    StateNotifierProvider<PopularTVState, List<TV>>((ref) => PopularTVState());
final tvDetailProvider =
    StateNotifierProvider<TVState, TV?>((ref) => TVState());

class TrendingTVState extends StateNotifier<List<TV>> {
  TrendingTVState() : super(<TV>[]);

  Future<bool> getTrendingTVs() async {
    final _tvTrending = await _tvService.getTrendingTVs();

    if (_tvTrending != null) {
      state.addAll(_tvTrending);
      return true;
    } else {
      return false;
    }
  }

  void clear() {
    state.clear();
  }
}

class TopRatedTVState extends StateNotifier<List<TV>> {
  TopRatedTVState() : super(<TV>[]);

  Future<bool> getTopRatedTVs() async {
    final _tvTrending = await _tvService.getTopRatedTVs();

    if (_tvTrending != null) {
      state.addAll(_tvTrending);
      return true;
    } else {
      return false;
    }
  }

  void clear() {
    state.clear();
  }
}

class TVState extends StateNotifier<TV?> {
  TVState() : super(null);

  Future<bool> getTVDetail(int id) async {
    final _tv = await _tvService.getTVDetail(id);

    if (_tv != null) {
      state = _tv;
      return true;
    } else {
      return false;
    }
  }
}

class SimilarMovieState extends StateNotifier<List<TV>> {
  SimilarMovieState() : super(<TV>[]);

  Future<bool> getSimilarTVs(int id) async {
    final _tvs = await _tvService.getSimilarTVs(id);

    if (_tvs != null) {
      clear();
      state.addAll(_tvs);
      return true;
    } else {
      return false;
    }
  }

  void clear() {
    state = [];
  }
}

class PopularTVState extends StateNotifier<List<TV>> {
  PopularTVState() : super(<TV>[]);

  Future<bool> getPopularTVs(int pn) async {
    final _movies = await _tvService.getPopularTVs(pn);

    print(_movies);

    if (_movies != null) {
      state.addAll(_movies);
      return true;
    } else {
      return false;
    }
  }

  void clear() {
    state = [];
  }
}
