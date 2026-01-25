import '../model/events_page_model.dart';
import '../../our_hotels/model/city_model.dart';

abstract class EventsState {}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final EventsPageModel data;
  final List<CityModel> cities;

  EventsLoaded({
    required this.data,
    required this.cities,
  });
}


class EventsSubmitting extends EventsState {}

class EventsSuccess extends EventsState {
  final String message;

  EventsSuccess(this.message);
}

class EventsError extends EventsState {
  final String message;

  EventsError(this.message);
}
