import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_movie_app/common/media_type.dart';
import 'package:the_movie_app/configs/config.dart';
import 'package:the_movie_app/models/video/video.dart';

class VideoService {
  Future<List<Video>?> getVideos(MediaTypeEnum mediaType, int id) async {
    try {
      final _mediaType = mediaType == MediaTypeEnum.movie ? 'movie' : 'tv';
      final _query = '${apiUrl()}/$_mediaType/$id/videos?${apiKey()}';
      final res = await http.get(
        Uri.parse(_query),
        headers: await headers(),
      );

      switch (res.statusCode) {
        case 200:
          final resBody = await jsonDecode(res.body) as Map<String, dynamic>;
          if (resBody.containsKey('results')) {
            final _videos = jsonToVideos(resBody);
            return _videos;
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

  static List<Video> jsonToVideos(Map<String, dynamic> res) {
    final tvs = <Video>[];
    res['results']?.asMap().forEach(
      (int i, dynamic item) {
        final tv = Video.fromJson(item as Map<String, dynamic>);
        tvs.add(tv);
      },
    );
    return tvs;
  }
}
