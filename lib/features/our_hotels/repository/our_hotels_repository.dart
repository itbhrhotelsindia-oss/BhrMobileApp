import 'dart:convert';

import '../../../core/api_client.dart';
import '../model/city_model.dart';
import '../model/our_hotels_model.dart';

class OurHotelsRepository {
  final ApiClient api;

  OurHotelsRepository(this.api);

  Future<List<CityModel>> loadCities() async {
    final res = await api.get("/api/cities/");

    return (res as List)
        .map((e) => CityModel.fromJson(e))
        .toList();
  }

  Future<OurHotelsModel> loadOurHotels() async {
    final res = await api.get("/api/our-hotels/");
    return OurHotelsModel.fromJson(res[0]);
  }
}

