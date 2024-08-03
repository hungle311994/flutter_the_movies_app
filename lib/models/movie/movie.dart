import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_movie_app/common/media_type.dart';
import 'package:the_movie_app/models/genre/genre.dart';
import 'package:the_movie_app/models/season/season.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  factory Movie({
    int? id,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    int? voteCount,
    int? runtime,
    double? voteAverage,
    double? popularity,
    String? title,
    String? backdropPath,
    String? firstAirDate,
    String? lastAirDate,
    String? releaseDate,
    String? originalLanguage,
    String? originalTitle,
    String? originalName,
    String? overview,
    String? posterPath,
    String? homepage,
    String? status,
    String? tagline,
    String? type,
    bool? adult,
    bool? video,
    MediaTypeEnum? mediaType,
    List<Genre>? genres,
    List<Season>? seasons,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
