import 'event_category_model.dart';

class EventsSectionModel {
  final String title;
  final String description;
  final List<EventCategoryModel> eventCategories;

  EventsSectionModel({
    required this.title,
    required this.description,
    required this.eventCategories,
  });

  factory EventsSectionModel.fromJson(Map<String, dynamic> json) {
    return EventsSectionModel(
      title: json['title'],
      description: json['description'],
      eventCategories: (json['eventCategories'] as List)
          .map((e) => EventCategoryModel.fromJson(e))
          .toList(),
    );
  }
}
