// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_register_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorRegisterRequestBody _$DoctorRegisterRequestBodyFromJson(
  Map<String, dynamic> json,
) => DoctorRegisterRequestBody(
  username: json['username'] as String,
  password: json['password'] as String,
  permission: (json['permission'] as num).toInt(),
);

Map<String, dynamic> _$DoctorRegisterRequestBodyToJson(
  DoctorRegisterRequestBody instance,
) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
  'permission': instance.permission,
};
