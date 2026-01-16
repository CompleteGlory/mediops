// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_register_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientRegisterRequestBody _$ClientRegisterRequestBodyFromJson(
  Map<String, dynamic> json,
) => ClientRegisterRequestBody(
  username: json['username'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$ClientRegisterRequestBodyToJson(
  ClientRegisterRequestBody instance,
) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
};
