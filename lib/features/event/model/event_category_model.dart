class EventCategoryModel {
  final String key;
  final String title;
  final String image;
  final String heading;
  final String description;

  EventCategoryModel({
    required this.key,
    required this.title,
    required this.image,
    required this.heading,
    required this.description,
  });

  factory EventCategoryModel.fromJson(Map<String, dynamic> json) {
    return EventCategoryModel(
      key: json['key'],
      title: json['title'],
      image: json['image'],
      heading: json['heading'],
      description: json['description'],
    );
  }
}
