import '../../../core/api_client.dart';
import '../../weddings/model/weddings_model.dart';

class WeddingsRepository {
  final ApiClient api;

  WeddingsRepository(this.api);

  Future<WeddingModel> loadWeddings() async {
    final response = await api.get('/api/weddings/');

    // API returns LIST
    return WeddingModel.fromJson(response[0]);
  }
}
