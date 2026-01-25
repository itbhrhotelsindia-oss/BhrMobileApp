import '../../../core/api_client.dart';
import '../model/events_page_model.dart';
import '../model/event_enquiry_model.dart';
import '../../our_hotels/model/city_model.dart';

class EventsRepository {
  final ApiClient api;

  EventsRepository(this.api);

  Future<EventsPageModel> loadEventsPage() async {
    final res = await api.get("/api/events-page");
    return EventsPageModel.fromJson(res);
  }

  Future<List<CityModel>> loadCities() async {
    final res = await api.get("/api/cities/");
    return (res as List).map((e) => CityModel.fromJson(e)).toList();
  }

  Future<void> submitEnquiry(EventEnquiryModel form) async {
    await api.post("/api/events/enquiry", form.toJson());
  }
}
