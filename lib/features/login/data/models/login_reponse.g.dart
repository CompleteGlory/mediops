// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['jwt'] as String,
      message: json['message'] as String,
      permission: (json['permission'] as num).toInt(),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'jwt': instance.token,
      'message': instance.message,
      'permission': instance.permission,
    };
