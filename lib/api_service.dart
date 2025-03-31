import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/user_model.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:3001/api/v1';

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
}
