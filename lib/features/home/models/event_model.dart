class EventsSectionModel {
  final String title;
  final String description;
  final List<EventItem> events;

  EventsSectionModel({
    required this.title,
    required this.description,
    required this.events,
  });

  factory EventsSectionModel.fromJson(
      Map<String, dynamic> json) {
    return EventsSectionModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      events: (json['events'] as List? ?? [])
          .map((e) => EventItem.fromJson(e))
          .toList(),
    );
  }
}

class EventItem {
  final String title;
  final String imageUrl;
  final String description;

  EventItem({
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
