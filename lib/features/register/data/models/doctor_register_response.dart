import 'package:json_annotation/json_annotation.dart';

part 'doctor_register_response.g.dart';

@JsonSerializable()
class DoctorRegisterResponse {
  final String? message;

  DoctorRegisterResponse({
    this.message,
  });

  factory DoctorRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorRegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorRegisterResponseToJson(this);
}
