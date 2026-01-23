import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient(this.baseUrl);

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
}
