import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient(this.baseUrl);

  /// GET
  Future<dynamic> get(String path) async {
    final response = await http.get(
      Uri.parse("$baseUrl$path"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("API error ${response.statusCode}");
    }

    return jsonDecode(response.body);
  }

  /// ✅ ADD THIS POST METHOD
  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse("$baseUrl$path"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception("API error ${response.statusCode}");
    }

    return jsonDecode(response.body);
  }
}
