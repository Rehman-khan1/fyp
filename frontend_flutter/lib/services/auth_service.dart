import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/backend_config.dart';

class AuthService {
  static final String baseUrl = BackendConfig.baseUrl;

  static Future<bool> login(String email, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/login');
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
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
