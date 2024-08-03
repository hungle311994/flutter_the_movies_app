import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
class Account with _$Account {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  factory Account({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? avatar,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
