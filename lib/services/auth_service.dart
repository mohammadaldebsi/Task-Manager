import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'database_helper.dart';

class AuthService {
  static const String baseUrl = 'https://dummyjson.com/auth';

  Future<void> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'expiresInMins': 30,
        }),
      );

      print('Login Status Code: ${response.statusCode}');
      print('Login Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final user = User.fromJson(responseData);
        final dbHelper = DatabaseHelper();
        await dbHelper.insertUser(user);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('authToken', responseData['token']);

      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      print('Login Error: $error');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getCurrentUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/me'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      print('Get Current User Status Code: ${response.statusCode}');
      print('Get Current User Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get current user');
      }
    } catch (error) {
      print('Get Current User Error: $error');
      rethrow;
    }
  }

  Future<String> refreshSession(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/refresh'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'refreshToken': refreshToken,
          'expiresInMins': 30, // optional, defaults to 60
        }),
      );

      print('Refresh Session Status Code: ${response.statusCode}');
      print('Refresh Session Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['token'];
      } else {
        throw Exception('Failed to refresh session');
      }
    } catch (error) {
      print('Refresh Session Error: $error');
      rethrow;
    }
  }
}
