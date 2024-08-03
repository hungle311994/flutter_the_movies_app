// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Movie _$_$_MovieFromJson(Map<String, dynamic> json) {
  return _$_Movie(
    id: json['id'] as int?,
    numberOfEpisodes: json['number_of_episodes'] as int?,
    numberOfSeasons: json['number_of_seasons'] as int?,
    voteCount: json['vote_count'] as int?,
    runtime: json['runtime'] as int?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    popularity: (json['popularity'] as num?)?.toDouble(),
    title: json['title'] as String?,
    backdropPath: json['backdrop_path'] as String?,
    firstAirDate: json['first_air_date'] as String?,
    lastAirDate: json['last_air_date'] as String?,
    releaseDate: json['release_date'] as String?,
    originalLanguage: json['original_language'] as String?,
    originalTitle: json['original_title'] as String?,
    originalName: json['original_name'] as String?,
    overview: json['overview'] as String?,
    posterPath: json['poster_path'] as String?,
    homepage: json['homepage'] as String?,
    status: json['status'] as String?,
    tagline: json['tagline'] as String?,
    type: json['type'] as String?,
    adult: json['adult'] as bool?,
    video: json['video'] as bool?,
    mediaType: _$enumDecodeNullable(_$MediaTypeEnumEnumMap, json['media_type']),
    genres: (json['genres'] as List<dynamic>?)
        ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
        .toList(),
    seasons: (json['seasons'] as List<dynamic>?)
        ?.map((e) => Season.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_MovieToJson(_$_Movie instance) => <String, dynamic>{
      'id': instance.id,
      'number_of_episodes': instance.numberOfEpisodes,
      'number_of_seasons': instance.numberOfSeasons,
      'vote_count': instance.voteCount,
      'runtime': instance.runtime,
      'vote_average': instance.voteAverage,
      'popularity': instance.popularity,
      'title': instance.title,
      'backdrop_path': instance.backdropPath,
      'first_air_date': instance.firstAirDate,
      'last_air_date': instance.lastAirDate,
      'release_date': instance.releaseDate,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'homepage': instance.homepage,
      'status': instance.status,
      'tagline': instance.tagline,
      'type': instance.type,
      'adult': instance.adult,
      'video': instance.video,
      'media_type': _$MediaTypeEnumEnumMap[instance.mediaType],
      'genres': instance.genres,
      'seasons': instance.seasons,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$MediaTypeEnumEnumMap = {
  MediaTypeEnum.movie: 'movie',
  MediaTypeEnum.tv: 'tv',
};
