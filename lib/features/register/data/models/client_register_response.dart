import 'package:json_annotation/json_annotation.dart';

part 'client_register_response.g.dart';

@JsonSerializable()
class ClientRegisterResponse {
  final String? message;

  ClientRegisterResponse({
    this.message,
  });

  factory ClientRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$ClientRegisterResponseFromJson(json);
}
