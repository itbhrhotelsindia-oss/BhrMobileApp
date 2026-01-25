import 'blog_detail_model.dart';

class BlogItemModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String htmlContent;
  final String? subtitle;
  final bool promo;
  final String? slug;

  BlogItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.htmlContent,
    this.subtitle,
    this.promo = false,
    this.slug,
  });

  factory BlogItemModel.fromJson(Map<String, dynamic> json) {
    return BlogItemModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      htmlContent: json['htmlContent'],
      subtitle: json['subtitle'],
      promo: json['promo'] ?? false,
      slug: json['slug'],
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
    );
  }
}
