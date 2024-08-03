// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Cast _$_$_CastFromJson(Map<String, dynamic> json) {
  return _$_Cast(
    id: json['id'] as int?,
    gender: json['gender'] as int?,
    order: json['order'] as int?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    adult: json['adult'] as bool?,
    name: json['name'] as String?,
    originalName: json['original_name'] as String?,
    character: json['character'] as String?,
    creditId: json['credit_id'] as String?,
    knownForDepartment: json['known_for_department'] as String?,
    profilePath: json['profile_path'] as String?,
  );
}

Map<String, dynamic> _$_$_CastToJson(_$_Cast instance) => <String, dynamic>{
      'id': instance.id,
      'gender': instance.gender,
      'order': instance.order,
      'popularity': instance.popularity,
      'adult': instance.adult,
      'name': instance.name,
      'original_name': instance.originalName,
      'character': instance.character,
      'credit_id': instance.creditId,
      'known_for_department': instance.knownForDepartment,
      'profile_path': instance.profilePath,
    };
