import '../../../core/api_client.dart';
import '../model/city_model.dart';
import '../model/partner_form_model.dart';

class PartnerRepository {
  final ApiClient api;

  PartnerRepository(this.api);

  Future<List<CityModel>> loadCities() async {
    final res = await api.get("/api/cities/");
    return (res as List)
        .map((e) => CityModel.fromJson(e))
        .toList();
  }

  Future<void> submitForm(PartnerFormModel form) async {
    await api.post(
      "/api/partner-with-us",
      form.toJson(),
    );
  }
}
