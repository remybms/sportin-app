// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgramResponseImpl _$$ProgramResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProgramResponseImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      name: json['name'] as String,
      favorite: json['favorite'] as bool,
      timestampModif: json['timestampModif'] as String,
      comment: json['comment'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      objectif: json['objectif'] as String,
      weightObjectif: (json['weightObjectif'] as num).toInt(),
    );

Map<String, dynamic> _$$ProgramResponseImplToJson(
        _$ProgramResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'favorite': instance.favorite,
      'timestampModif': instance.timestampModif,
      'comment': instance.comment,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'objectif': instance.objectif,
      'weightObjectif': instance.weightObjectif,
    };

_$ProgramImpl _$$ProgramImplFromJson(Map<String, dynamic> json) =>
    _$ProgramImpl(
      userId: (json['userId'] as num).toInt(),
      name: json['name'] as String,
      favorite: json['favorite'] as bool,
      comment: json['comment'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      objectif: json['objectif'] as String,
      weightObjectif: (json['weightObjectif'] as num).toInt(),
    );

Map<String, dynamic> _$$ProgramImplToJson(_$ProgramImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'favorite': instance.favorite,
      'comment': instance.comment,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'objectif': instance.objectif,
      'weightObjectif': instance.weightObjectif,
    };
