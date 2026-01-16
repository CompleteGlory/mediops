import 'package:json_annotation/json_annotation.dart';

part 'client_register_request_body.g.dart';

@JsonSerializable()
class ClientRegisterRequestBody {
  final String username;
  final String password;

  ClientRegisterRequestBody({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$ClientRegisterRequestBodyToJson(this);
}
