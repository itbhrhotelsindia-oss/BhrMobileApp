import 'event_slider_model.dart';
import 'event_category_model.dart';
import 'events_section_model.dart';

class EventsPageModel {
  final String id;
  final String pageTitle;
  final EventSliderModel eventSlider;
  final EventsSectionModel eventsSection;

  EventsPageModel({
    required this.id,
    required this.pageTitle,
    required this.eventSlider,
    required this.eventsSection,
  });

  factory EventsPageModel.fromJson(Map<String, dynamic> json) {
    return EventsPageModel(
      id: json['id'],
      pageTitle: json['pageTitle'],
      eventSlider: EventSliderModel.fromJson(json['eventSlider']),
      eventsSection:
      EventsSectionModel.fromJson(json['eventsSection']),
    );
  }
}
