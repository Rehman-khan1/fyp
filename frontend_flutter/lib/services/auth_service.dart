import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://10.0.2.2:8000";

  static Future<bool> login(String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 5));

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }
}
