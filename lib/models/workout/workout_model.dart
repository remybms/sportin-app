import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_model.freezed.dart';
part 'workout_model.g.dart';

@freezed
class WorkoutResponse with _$WorkoutResponse {
  const factory WorkoutResponse({
    required int id,
    required String name,
    required int programId,
    required String color,
  }) = _WorkoutResponse;

  factory WorkoutResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkoutResponseFromJson(json);
}

@freezed
class Workout with _$Workout {
  const factory Workout({
    required String name,
    required int programId,
    required String color,
  }) = _Workout;

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);
}
