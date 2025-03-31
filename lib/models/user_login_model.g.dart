// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserLoginResponseImpl _$$UserLoginResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UserLoginResponseImpl(
      token: json['token'] as String,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$$UserLoginResponseImplToJson(
        _$UserLoginResponseImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userId': instance.userId,
    };

_$UserLoginImpl _$$UserLoginImplFromJson(Map<String, dynamic> json) =>
    _$UserLoginImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$UserLoginImplToJson(_$UserLoginImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
