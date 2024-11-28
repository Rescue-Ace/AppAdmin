import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://careful-stunning-snake.ngrok-free.app';

  // Login admin
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/admin/loginAdmin');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Login gagal: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Kesalahan login: $e');
    }
  }
}
