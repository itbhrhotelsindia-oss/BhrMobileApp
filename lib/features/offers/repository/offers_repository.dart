import '../../../core/api_client.dart';
import '../model/offer_model.dart';

class OffersRepository {
  final ApiClient api;

  OffersRepository(this.api);

  Future<List<OfferModel>> loadOffers() async {
    final res = await api.get("/api/offers");

    return (res as List)
        .map((e) => OfferModel.fromJson(e))
        .toList();
  }
}
