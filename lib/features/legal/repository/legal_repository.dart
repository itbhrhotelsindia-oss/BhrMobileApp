import '../../../core/api_client.dart';
import '../model/legal_page_model.dart';

class LegalRepository {
  final ApiClient api;

  LegalRepository(this.api);

  Future<LegalPageModel> loadLegalPage(String apiPath) async {
    final res = await api.get(apiPath);
    return LegalPageModel.fromJson(res);
  }
}
