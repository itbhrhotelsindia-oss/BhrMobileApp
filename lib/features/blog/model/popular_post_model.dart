import 'blog_detail_model.dart';

class PopularPostModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String htmlContent;
  final String? slug;
  final String? author;
  final String? date;

  PopularPostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.htmlContent,
    this.slug,
    this.author,
    this.date,
  });

  factory PopularPostModel.fromJson(Map<String, dynamic> json) {
    return PopularPostModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      htmlContent: json['htmlContent'],
      slug: json['slug'],
      author: json['author'],
      date: json['date'],
    );
  }

  /// ✅ ADD THIS
  BlogDetailModel toDetailModel() {
    return BlogDetailModel(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      htmlContent: htmlContent,
      slug: slug,
      author: author,
      date: date,
    );
  }
}
