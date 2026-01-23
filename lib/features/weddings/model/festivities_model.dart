
class FestivitiesModel {
  final String title;
  final String description;
  final List<FestivityItemModel> festivitiesList;

  FestivitiesModel({
    required this.title,
    required this.description,
    required this.festivitiesList,
  });

  factory FestivitiesModel.fromJson(Map<String, dynamic> json) {
    return FestivitiesModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      festivitiesList: (json['festivitiesList'] as List? ?? [])
          .map((e) => FestivityItemModel.fromJson(e))
          .toList(),
    );
  }
}

class FestivityItemModel {
  final String title;
  final String text;
  final String imageUrl;
  final String layout;

  FestivityItemModel({
    required this.title,
    required this.text,
    required this.imageUrl,
    required this.layout,
  });

  factory FestivityItemModel.fromJson(Map<String, dynamic> json) {
    return FestivityItemModel(
      title: json['title'] ?? '',
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      layout: json['layout'] ?? 'image-left',
    );
  }
}

