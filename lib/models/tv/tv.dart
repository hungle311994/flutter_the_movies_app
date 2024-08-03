import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_movie_app/common/media_type.dart';
import 'package:the_movie_app/models/genre/genre.dart';
import 'package:the_movie_app/models/season/season.dart';

part 'tv.freezed.dart';
part 'tv.g.dart';

@freezed
class TV with _$TV {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  factory TV({
    int? id,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    int? voteCount,
    double? voteAverage,
    double? popularity,
    String? name,
    String? backdropPath,
    String? firstAirDate,
    String? lastAirDate,
    String? originalLanguage,
    String? originalName,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? homepage,
    String? status,
    String? tagline,
    bool? adult,
    bool? inProduction,
    MediaTypeEnum? mediaType,
    List<Genre>? genres,
    List<Season>? seasons,
  }) = _TV;

  factory TV.fromJson(Map<String, dynamic> json) => _$TVFromJson(json);
}
