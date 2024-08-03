import 'package:freezed_annotation/freezed_annotation.dart';

part 'cast.freezed.dart';
part 'cast.g.dart';

@freezed
class Cast with _$Cast {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  factory Cast({
    int? id,
    int? gender,
    int? order,
    double? popularity,
    bool? adult,
    String? name,
    String? originalName,
    String? character,
    String? creditId,
    String? knownForDepartment,
    String? profilePath,
  }) = _Cast;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}
