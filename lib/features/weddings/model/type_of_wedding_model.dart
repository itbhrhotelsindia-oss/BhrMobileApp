
class TypeOfWeddingModel {
  final String title;
  final String description;
  final List<WeddingTypeItemModel> weddingList;

  TypeOfWeddingModel({
    required this.title,
    required this.description,
    required this.weddingList,
  });

  factory TypeOfWeddingModel.fromJson(Map<String, dynamic> json) {
    return TypeOfWeddingModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      weddingList: (json['weddingList'] as List? ?? [])
          .map((e) => WeddingTypeItemModel.fromJson(e))
          .toList(),
    );
  }
}

class WeddingTypeItemModel {
  final String title;
  final String text;
  final String imageUrl;

  WeddingTypeItemModel({
    required this.title,
    required this.text,
    required this.imageUrl,
  });

  factory WeddingTypeItemModel.fromJson(Map<String, dynamic> json) {
    return WeddingTypeItemModel(
      title: json['title'] ?? '',
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
