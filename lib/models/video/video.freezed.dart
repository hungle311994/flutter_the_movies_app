// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Video _$VideoFromJson(Map<String, dynamic> json) {
  return _Video.fromJson(json);
}

/// @nodoc
class _$VideoTearOff {
  const _$VideoTearOff();

  _Video call(
      {String? id,
      String? key,
      String? name,
      String? publishedAt,
      String? site,
      String? type,
      int? size,
      bool? official}) {
    return _Video(
      id: id,
      key: key,
      name: name,
      publishedAt: publishedAt,
      site: site,
      type: type,
      size: size,
      official: official,
    );
  }

  Video fromJson(Map<String, Object> json) {
    return Video.fromJson(json);
  }
}

/// @nodoc
const $Video = _$VideoTearOff();

/// @nodoc
mixin _$Video {
  String? get id => throw _privateConstructorUsedError;
  String? get key => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get publishedAt => throw _privateConstructorUsedError;
  String? get site => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  int? get size => throw _privateConstructorUsedError;
  bool? get official => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoCopyWith<Video> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoCopyWith<$Res> {
  factory $VideoCopyWith(Video value, $Res Function(Video) then) =
      _$VideoCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? key,
      String? name,
      String? publishedAt,
      String? site,
      String? type,
      int? size,
      bool? official});
}

/// @nodoc
class _$VideoCopyWithImpl<$Res> implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._value, this._then);

  final Video _value;
  // ignore: unused_field
  final $Res Function(Video) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? key = freezed,
    Object? name = freezed,
    Object? publishedAt = freezed,
    Object? site = freezed,
    Object? type = freezed,
    Object? size = freezed,
    Object? official = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedAt: publishedAt == freezed
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      site: site == freezed
          ? _value.site
          : site // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      official: official == freezed
          ? _value.official
          : official // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$VideoCopyWith<$Res> implements $VideoCopyWith<$Res> {
  factory _$VideoCopyWith(_Video value, $Res Function(_Video) then) =
      __$VideoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? key,
      String? name,
      String? publishedAt,
      String? site,
      String? type,
      int? size,
      bool? official});
}

/// @nodoc
class __$VideoCopyWithImpl<$Res> extends _$VideoCopyWithImpl<$Res>
    implements _$VideoCopyWith<$Res> {
  __$VideoCopyWithImpl(_Video _value, $Res Function(_Video) _then)
      : super(_value, (v) => _then(v as _Video));

  @override
  _Video get _value => super._value as _Video;

  @override
  $Res call({
    Object? id = freezed,
    Object? key = freezed,
    Object? name = freezed,
    Object? publishedAt = freezed,
    Object? site = freezed,
    Object? type = freezed,
    Object? size = freezed,
    Object? official = freezed,
  }) {
    return _then(_Video(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedAt: publishedAt == freezed
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      site: site == freezed
          ? _value.site
          : site // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      official: official == freezed
          ? _value.official
          : official // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Video implements _Video {
  _$_Video(
      {this.id,
      this.key,
      this.name,
      this.publishedAt,
      this.site,
      this.type,
      this.size,
      this.official});

  factory _$_Video.fromJson(Map<String, dynamic> json) =>
      _$_$_VideoFromJson(json);

  @override
  final String? id;
  @override
  final String? key;
  @override
  final String? name;
  @override
  final String? publishedAt;
  @override
  final String? site;
  @override
  final String? type;
  @override
  final int? size;
  @override
  final bool? official;

  @override
  String toString() {
    return 'Video(id: $id, key: $key, name: $name, publishedAt: $publishedAt, site: $site, type: $type, size: $size, official: $official)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Video &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.publishedAt, publishedAt) ||
                const DeepCollectionEquality()
                    .equals(other.publishedAt, publishedAt)) &&
            (identical(other.site, site) ||
                const DeepCollectionEquality().equals(other.site, site)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.official, official) ||
                const DeepCollectionEquality()
                    .equals(other.official, official)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(publishedAt) ^
      const DeepCollectionEquality().hash(site) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(official);

  @JsonKey(ignore: true)
  @override
  _$VideoCopyWith<_Video> get copyWith =>
      __$VideoCopyWithImpl<_Video>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_VideoToJson(this);
  }
}

abstract class _Video implements Video {
  factory _Video(
      {String? id,
      String? key,
      String? name,
      String? publishedAt,
      String? site,
      String? type,
      int? size,
      bool? official}) = _$_Video;

  factory _Video.fromJson(Map<String, dynamic> json) = _$_Video.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get key => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get publishedAt => throw _privateConstructorUsedError;
  @override
  String? get site => throw _privateConstructorUsedError;
  @override
  String? get type => throw _privateConstructorUsedError;
  @override
  int? get size => throw _privateConstructorUsedError;
  @override
  bool? get official => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$VideoCopyWith<_Video> get copyWith => throw _privateConstructorUsedError;
}
