import 'package:freezed_annotation/freezed_annotation.dart';

enum MediaTypeEnum {
  @JsonValue('movie')
  movie,
  @JsonValue('tv')
  tv,
}
