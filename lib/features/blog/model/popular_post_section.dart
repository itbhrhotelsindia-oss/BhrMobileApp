import 'popular_post_model.dart';

class PopularPostSection {
  final String id;
  final String title;
  final String description;
  final List<PopularPostModel> postsList;

  PopularPostSection({
    required this.id,
    required this.title,
    required this.description,
    required this.postsList,
  });

  factory PopularPostSection.fromJson(Map<String, dynamic> json) {
    return PopularPostSection(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      postsList: (json['postsList'] as List? ?? [])
          .map((e) => PopularPostModel.fromJson(e))
          .toList(),
    );
  }
}
