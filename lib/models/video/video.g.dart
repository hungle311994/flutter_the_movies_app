// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Video _$_$_VideoFromJson(Map<String, dynamic> json) {
  return _$_Video(
    id: json['id'] as String?,
    key: json['key'] as String?,
    name: json['name'] as String?,
    publishedAt: json['published_at'] as String?,
    site: json['site'] as String?,
    type: json['type'] as String?,
    size: json['size'] as int?,
    official: json['official'] as bool?,
  );
}

Map<String, dynamic> _$_$_VideoToJson(_$_Video instance) => <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
      'published_at': instance.publishedAt,
      'site': instance.site,
      'type': instance.type,
      'size': instance.size,
      'official': instance.official,
    };
