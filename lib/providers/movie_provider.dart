import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_movie_app/models/movie/movie.dart';
import 'package:the_movie_app/services/movie_service.dart';

final _movieService = MovieService();
final trendingMovieProvider =
    StateNotifierProvider<TrendingMovieState, List<Movie>>(
        (ref) => TrendingMovieState());
final topRatedMovieProvider =
    StateNotifierProvider<TopRatedMovieState, List<Movie>>(
        (ref) => TopRatedMovieState());
final similarMovieProvider =
    StateNotifierProvider<SimilarMovieState, List<Movie>>(
        (ref) => SimilarMovieState());
final popularMovieProvider =
    StateNotifierProvider<PopularMovieState, List<Movie>>(
        (ref) => PopularMovieState());
final movieDetailProvider =
    StateNotifierProvider<MovieState, Movie?>((ref) => MovieState());

class TrendingMovieState extends StateNotifier<List<Movie>> {
  TrendingMovieState() : super(<Movie>[]);

  Future<bool> getTrendingMovies() async {
    final _movies = await _movieService.getTrendingMovies();

    if (_movies != null) {
      state.addAll(_movies);
      return true;
    } else {
      return false;
    }
  }
}

class TopRatedMovieState extends StateNotifier<List<Movie>> {
  TopRatedMovieState() : super(<Movie>[]);

  Future<bool> getTopRatedMovies() async {
    final _movies = await _movieService.getTopRatedMovies();

    if (_movies != null) {
      state.addAll(_movies);
      return true;
    } else {
      return false;
    }
  }
}

class MovieState extends StateNotifier<Movie?> {
  MovieState() : super(null);

  Future<bool> getMovieDetail(int id) async {
    final _movie = await _movieService.getMovieDetail(id);

    if (_movie != null) {
      state = _movie;
      return true;
    } else {
      return false;
    }
  }
}

class SimilarMovieState extends StateNotifier<List<Movie>> {
  SimilarMovieState() : super(<Movie>[]);

  Future<bool> getSimilarMovies(int id) async {
    final _movies = await _movieService.getSimilarMovies(id);

    if (_movies != null) {
      clear();
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

class PopularMovieState extends StateNotifier<List<Movie>> {
  PopularMovieState() : super(<Movie>[]);

  Future<bool> getPopularMovies(int pn) async {
    final _movies = await _movieService.getPopularMovies(pn);

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
