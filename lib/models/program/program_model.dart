import 'package:freezed_annotation/freezed_annotation.dart';

part 'program_model.freezed.dart';
part 'program_model.g.dart';

@freezed
class ProgramResponse with _$ProgramResponse {
  const factory ProgramResponse({
    required int id,
    required int userId,
    required String name,
    required bool favorite,
    required String timestampModif,
    required String comment,
    required String startDate,
    required String endDate,
    required String objectif,
    required int weightObjectif,
    required int workoutCount,
  }) = _ProgramResponse;

  factory ProgramResponse.fromJson(Map<String, dynamic> json) =>
      _$ProgramResponseFromJson(json);
}

@freezed
class Program with _$Program {
  const factory Program({
    required int userId,
    required String name,
    required bool favorite,
    required String comment,
    required String startDate,
    required String endDate,
    required String objectif,
    required int weightObjectif,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
}
