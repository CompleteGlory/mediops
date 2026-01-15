import 'package:json_annotation/json_annotation.dart';

part 'register_request_body.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  final String name;
  final String password;

  RegisterRequestBody({
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);
}
