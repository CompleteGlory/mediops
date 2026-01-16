import 'package:json_annotation/json_annotation.dart';

part 'doctor_register_request_body.g.dart';

@JsonSerializable()
class DoctorRegisterRequestBody {
  final String username;
  final String password;
  final int permission;

  DoctorRegisterRequestBody({
    required this.username,
    required this.password,
    required this.permission,
  });

  Map<String, dynamic> toJson() => _$DoctorRegisterRequestBodyToJson(this);
}
