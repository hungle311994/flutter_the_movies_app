import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_movie_app/configs/config.dart';
import 'package:the_movie_app/models/tv/tv.dart';

class TVService {
  Future<List<TV>?> getTrendingTVs() async {
    try {
      final _query = '${apiUrl()}/trending/tv/day?${apiKey()}';
      final res = await http.get(
        Uri.parse(_query),
        headers: await headers(),
      );

      switch (res.statusCode) {
        case 200:
          final resBody = await jsonDecode(res.body) as Map<String, dynamic>;
          if (resBody.containsKey('results')) {
            final _tvs = jsonToTVs(resBody);
            return _tvs;
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

  Future<List<TV>?> getTopRatedTVs() async {
    try {
      final _query = '${apiUrl()}/tv/top_rated?${apiKey()}';
      final res = await http.get(
        Uri.parse(_query),
        headers: await headers(),
      );

      switch (res.statusCode) {
        case 200:
          final resBody = await jsonDecode(res.body) as Map<String, dynamic>;
          if (resBody.containsKey('results')) {
            final _tvs = jsonToTVs(resBody);
            return _tvs;
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

  Future<List<TV>?> getSimilarTVs(int id) async {
    try {
      final _query = '${apiUrl()}/tv/$id/similar?${apiKey()}&page=1';
      final res = await http.get(
        Uri.parse(_query),
        headers: await headers(),
      );

      switch (res.statusCode) {
        case 200:
          final resBody = await jsonDecode(res.body) as Map<String, dynamic>;
          if (resBody.containsKey('results')) {
            final _movies = jsonToTVs(resBody);
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

  Future<List<TV>?> getPopularTVs(int pn) async {
    try {
      final _query = '${apiUrl()}/tv/popular?${apiKey()}&page=$pn';
      final res = await http.get(
        Uri.parse(_query),
        headers: await headers(),
      );

      switch (res.statusCode) {
        case 200:
          final resBody = await jsonDecode(res.body) as Map<String, dynamic>;
          if (resBody.containsKey('results')) {
            final _tvs = jsonToTVs(resBody);
            return _tvs;
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

  static List<TV> jsonToTVs(Map<String, dynamic> res) {
    final tvs = <TV>[];
    res['results']?.asMap().forEach(
      (int i, dynamic item) {
        final tv = TV.fromJson(item as Map<String, dynamic>);
        tvs.add(tv);
      },
    );
    return tvs;
  }

  Future<TV?> getTVDetail(int id) async {
    try {
      final _query = '${apiUrl()}/tv/$id?${apiKey()}';
      final res = await http.get(
        Uri.parse(_query),
        headers: await headers(),
      );

      switch (res.statusCode) {
        case 200:
          final resBody = await jsonDecode(res.body) as Map<String, dynamic>;
          final _tvs = TV.fromJson(resBody);
          return _tvs;
        default:
          return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
