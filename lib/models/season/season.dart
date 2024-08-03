import 'package:freezed_annotation/freezed_annotation.dart';

part 'season.freezed.dart';
part 'season.g.dart';

@freezed
class Season with _$Season {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  factory Season({
    int? id,
    int? episodeCount,
    int? seasonNumber,
    double? voteAverage,
    String? name,
    String? airDate,
    String? overview,
    String? posterPath,
  }) = _Season;

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
}
