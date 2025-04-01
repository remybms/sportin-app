import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportin/models/category/category_model.dart';
import 'package:sportin/models/program/program_model.dart';
import 'package:sportin/models/user_login_model.dart';
import 'package:sportin/models/workout/workout_model.dart';
import 'models/user_model.dart';

class ApiService {
  final String baseUrl = 'http://dpocean.com:3001/api/v1';

  Future<UserResponse> createUser(User user) async {
    final response = await http.post(
      Uri.parse(baseUrl + '/users/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
  }

  Future<UserLoginResponse> loginUser(UserLogin userLogin) async {
    final response = await http.post(
      Uri.parse(baseUrl + '/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userLogin.toJson()),
    );

    if (response.statusCode == 200) {
      return UserLoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
  }

  Future<List<ProgramResponse>> getPrograms() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('api_token');

    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }

    final response = await http.get(
      Uri.parse(baseUrl + '/programs/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)
          .map<ProgramResponse>((json) => ProgramResponse.fromJson(json))
          .toList()
          .cast<ProgramResponse>();
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
  }

  Future<ProgramResponse> createProgram(Program program) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('api_token');

    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }

    final response = await http.post(
      Uri.parse(baseUrl + '/programs/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
      body: json.encode(program.toJson()), // Add the program data here
    );

    if (response.statusCode == 201) {
      return ProgramResponse.fromJson(json.decode(response.body));
    } else {
      print('Error: ${response.statusCode}');
      throw Exception(json.decode(response.body)['message']);
    }
  }

  Future<WorkoutResponse> createWorkout(Workout workout) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('api_token');

    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }

    final response = await http.post(
      Uri.parse(baseUrl + '/workouts/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
      body: json.encode(workout.toJson()), // Add the workout data here
    );

    if (response.statusCode == 201) {
      return WorkoutResponse.fromJson(json.decode(response.body));
    } else {
      print('Error: ${response.statusCode}');
      throw Exception(json.decode(response.body)['message']);
    }
  }

  Future<List<WorkoutResponse>> getWorkoutsByProgramId(int programId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('api_token');

    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }

    final response = await http.get(
      Uri.parse(baseUrl + '/workouts/program/' + programId.toString()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    );

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      print('Status Code: ${response.statusCode}');
      return json
          .decode(response.body)
          .map<WorkoutResponse>((json) => WorkoutResponse.fromJson(json))
          .toList();
    } else {
      print('Error: ${response.statusCode}');
      throw Exception(json.decode(response.body)['message']);
    }
  }

  Future<List<CategoryResponse>> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('api_token');

    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }

    final response = await http.get(
      Uri.parse(baseUrl + '/categories/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    );

    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map<CategoryResponse>((json) => CategoryResponse.fromJson(json))
          .toList();
    } else {
      print('Error: ${response.statusCode}');
      throw Exception(json.decode(response.body)['message']);
    }
  }
}
