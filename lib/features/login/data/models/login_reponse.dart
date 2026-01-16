import 'package:json_annotation/json_annotation.dart';

part 'login_reponse.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'jwt')
  final String? token;

  final String? message;

  final int? permission;

  LoginResponse({
    this.token,
    this.message,
    this.permission,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
