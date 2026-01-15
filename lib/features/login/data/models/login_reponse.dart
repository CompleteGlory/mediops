import 'package:json_annotation/json_annotation.dart';

part 'login_reponse.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'jwt')
  final String token;

  final String message;

  final int permission;

  LoginResponse({
    required this.token,
    required this.message,
    required this.permission,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
