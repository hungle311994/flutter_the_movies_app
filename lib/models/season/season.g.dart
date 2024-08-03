// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Season _$_$_SeasonFromJson(Map<String, dynamic> json) {
  return _$_Season(
    id: json['id'] as int?,
    episodeCount: json['episode_count'] as int?,
    seasonNumber: json['season_number'] as int?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    name: json['name'] as String?,
    airDate: json['air_date'] as String?,
    overview: json['overview'] as String?,
    posterPath: json['poster_path'] as String?,
  );
}

Map<String, dynamic> _$_$_SeasonToJson(_$_Season instance) => <String, dynamic>{
      'id': instance.id,
      'episode_count': instance.episodeCount,
      'season_number': instance.seasonNumber,
      'vote_average': instance.voteAverage,
      'name': instance.name,
      'air_date': instance.airDate,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
    };
