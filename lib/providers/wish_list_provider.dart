import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_movie_app/models/movie/movie.dart';
import 'package:the_movie_app/models/tv/tv.dart';

final movieWishListProvider =
    StateNotifierProvider<MovieWishListState, List<Movie>>(
        (ref) => MovieWishListState());
final tvWishListProvider = StateNotifierProvider<TVWishListState, List<TV>>(
    (ref) => TVWishListState());

class MovieWishListState extends StateNotifier<List<Movie>> {
  MovieWishListState() : super(<Movie>[]);

  Future<bool> addWishList(Movie? movie) async {
    if (movie == null) {
      return false;
    }

    if (state.isEmpty) {
      state.add(movie);
      return true;
    } else {
      final _movieAdded = state.firstWhere(
        (item) => item.id == movie.id,
        orElse: () => Movie(id: null),
      );

      if (_movieAdded.id == null) {
        state.add(movie);
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> removeWishList(Movie? movie) async {
    if (movie == null) {
      return false;
    }

    final _removeMovieId = state.firstWhere((item) => item.id == movie.id).id;

    if (_removeMovieId != null) {
      state.removeWhere((item) => item.id == _removeMovieId);
      return true;
    } else {
      return false;
    }
  }

  void clear() {
    state = [];
  }
}

class TVWishListState extends StateNotifier<List<TV>> {
  TVWishListState() : super(<TV>[]);

  Future<bool> addWishList(TV? tv) async {
    if (tv == null) {
      return false;
    }

    if (state.isEmpty) {
      state.add(tv);
      return true;
    } else {
      final _hasTVAdded = state.firstWhere(
        (item) => item.id == tv.id,
        orElse: () => TV(id: null),
      );

      if (_hasTVAdded.id == null) {
        state.add(tv);
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> removeWishList(TV? tv) async {
    if (tv == null) {
      return false;
    }

    final _removeTVId = state.firstWhere((item) => item.id == tv.id).id;

    if (_removeTVId != null) {
      state.removeWhere((item) => item.id == _removeTVId);
      return true;
    } else {
      return false;
    }
  }

  void clear() {
    state = [];
  }
}
