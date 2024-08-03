import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_movie_app/common/media_type.dart';
import 'package:the_movie_app/models/cast/cast.dart';
import 'package:the_movie_app/services/cast_service.dart';

final _castService = CastService();
final castProvider =
    StateNotifierProvider<CastState, List<Cast>>((ref) => CastState());

class CastState extends StateNotifier<List<Cast>> {
  CastState() : super(<Cast>[]);

  Future<bool> getCasts(MediaTypeEnum mediaType, int id) async {
    final _casts = await _castService.getCasts(mediaType, id);

    if (_casts != null) {
      state = _casts;
      return true;
    } else {
      return false;
    }
  }

  void clear() {
    state = [];
  }
}
