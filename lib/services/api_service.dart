import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://rescue-ace.ddns.net';

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

  // Mendapatkan lokasi alat
  Future<List<Map<String, dynamic>>> getAlatLocations() async {
    final url = Uri.parse('$baseUrl/Alat');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Gagal mendapatkan lokasi alat: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Kesalahan saat mengambil data alat: $e');
    }
  }

  Future<void> addAlat(Map<String, dynamic> alatData) async {
    final url = Uri.parse('$baseUrl/Alat');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(alatData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        // Gagal menambahkan alat
        throw Exception(
            'Gagal menambahkan alat: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Kesalahan saat menambahkan alat: $e');
    }
  }

  Future<void> updateAdminProfile(int idAdmin, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/admin/$idAdmin');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui profil');
    }
  }

  Future<void> updateAdminPassword(int idAdmin, Map<String, dynamic> passwordData) async {
    final url = Uri.parse('$baseUrl/admin/updatePassword/$idAdmin');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(passwordData),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal mengganti password');
    }
  }

}
