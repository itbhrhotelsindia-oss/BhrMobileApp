import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/api_client.dart';
import '../model/city_model.dart';

class HeaderRepository {
  final ApiClient api;

  HeaderRepository(this.api);

  Future<List<CityModel>> fetchCities() async {
    final response = await api.get("/api/cities/");

    final List data = jsonDecode(response);

    return data.map((e) => CityModel.fromJson(e)).toList();
  }
}
