import 'dart:convert';
import '../../../core/api_client.dart';
import '../models/home_model.dart';

class HomeRepository {
  final ApiClient api;

  HomeRepository(this.api);

  Future<HomeModel> loadHome() async {
    final json = await api.get("/api/home");
    return HomeModel.fromJson(json);
  }
}

