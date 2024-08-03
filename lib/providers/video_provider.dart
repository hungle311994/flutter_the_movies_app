import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_movie_app/common/media_type.dart';
import 'package:the_movie_app/models/video/video.dart';
import 'package:the_movie_app/services/video_service.dart';

final _videoService = VideoService();
final videoProvider =
    StateNotifierProvider.autoDispose<VideoState, List<Video>>(
        (ref) => VideoState());

class VideoState extends StateNotifier<List<Video>> {
  VideoState() : super(<Video>[]);

  Future<bool> getVideos(MediaTypeEnum mediaType, int id) async {
    final _videos = await _videoService.getVideos(mediaType, id);

    if (_videos != null) {
      state = _videos;
      return true;
    } else {
      return false;
    }
  }

  void clear() {
    state = [];
  }
}
