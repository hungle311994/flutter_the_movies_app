import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_movie_app/configs/config.dart';
import 'package:the_movie_app/models/movie/movie.dart';

class MovieService {
  Future<List<Movie>?> getTrendingMovies() async {
    try {
      final _query = '${apiUrl()}/trending/movie/day?${apiKey()}';
      final res = await http.get(
        Uri.parse(_query),
        headers: await headers(),
      );

      switch (res.statusCode) {
        case 200:
          final resBody = await jsonDecode(res.body) as Map<String, dynamic>;
          if (resBody.containsKey('results')) {
            final _movies = jsonToMovies(resBody);
            return _movies;
          } else {
            return null;
          }
        default:
          return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Movie>?> getTopRatedMovies() async {
    try {
      final _query = '${apiUrl()}/movie/top_rated?${apiKey()}&page=1';
      final res = await http.get(
        Uri.parse(_query),
        headers: await headers(),
      );

      switch (res.statusCode) {
        case 200:
          final resBody = await jsonDecode(res.body) as Map<String, dynamic>;
          if (resBody.containsKey('results')) {
            final _movies = jsonToMovies(resBody);
            return _movies;
          } else {
            return null;
          }
        default:
          return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Movie>?> getSimilarMovies(int id) async {
    try {
      final _query = '${apiUrl()}/movie/$id/similar?${apiKey()}&page=1';
      final res = await http.get(
        Uri.parse(_query),
        headers: await headers(),
      );

      switch (res.statusCode) {
        case 200:
          final resBody = await jsonDecode(res.body) as Map<String, dynamic>;
          if (resBody.containsKey('results')) {
            final _movies = jsonToMovies(resBody);
            return _movies;
          } else {
            return null;
          }
        default:
          return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Movie>?> getPopularMovies(int pn) async {
    try {
      final _query = '${apiUrl()}/movie/popular?${apiKey()}&page=$pn';
      final res = await http.get(
        Uri.parse(_query),
        headers: await headers(),
      );

      switch (res.statusCode) {
        case 200:
          final resBody = await jsonDecode(res.body) as Map<String, dynamic>;
          if (resBody.containsKey('results')) {
            final _movies = jsonToMovies(resBody);
            return _movies;
          } else {
            return null;
          }
        default:
          return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  static List<Movie> jsonToMovies(Map<String, dynamic> res) {
    final movies = <Movie>[];
    res['results']?.asMap().forEach(
      (int i, dynamic item) {
        final movie = Movie.fromJson(item as Map<String, dynamic>);
        movies.add(movie);
      },
    );
    return movies;
  }

  Future<Movie?> getMovieDetail(int id) async {
    try {
      final _query = '${apiUrl()}/movie/$id?${apiKey()}';
      final res = await http.get(
        Uri.parse(_query),
        headers: await headers(),
      );

      switch (res.statusCode) {
        case 200:
          final resBody = await jsonDecode(res.body) as Map<String, dynamic>;
          final _movies = Movie.fromJson(resBody);
          return _movies;
        default:
          return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
