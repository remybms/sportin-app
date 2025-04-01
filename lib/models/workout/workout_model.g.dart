// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutResponseImpl _$$WorkoutResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WorkoutResponseImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      programId: (json['programId'] as num).toInt(),
      color: json['color'] as String,
    );

Map<String, dynamic> _$$WorkoutResponseImplToJson(
        _$WorkoutResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'programId': instance.programId,
      'color': instance.color,
    };

_$WorkoutImpl _$$WorkoutImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutImpl(
      name: json['name'] as String,
      programId: (json['programId'] as num).toInt(),
      color: json['color'] as String,
    );

Map<String, dynamic> _$$WorkoutImplToJson(_$WorkoutImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'programId': instance.programId,
      'color': instance.color,
    };
