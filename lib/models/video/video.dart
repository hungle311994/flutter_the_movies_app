import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  factory Video({
    String? id,
    String? key,
    String? name,
    String? publishedAt,
    String? site,
    String? type,
    int? size,
    bool? official,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
