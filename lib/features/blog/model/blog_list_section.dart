import 'blog_item_model.dart';

class BlogListSection {
  final String id;
  final String title;
  final String description;
  final List<BlogItemModel> blogsList;

  BlogListSection({
    required this.id,
    required this.title,
    required this.description,
    required this.blogsList,
  });

  factory BlogListSection.fromJson(Map<String, dynamic> json) {
    return BlogListSection(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      blogsList: (json['blogsList'] as List? ?? [])
          .map((e) => BlogItemModel.fromJson(e))
          .toList(),
    );
  }
}
