import 'blog_list_section.dart';
import 'popular_post_section.dart';

class BlogModel {
  final String id;
  final String title;
  final String description;
  final double? rating;
  final List<String> blogImages;
  final BlogListSection blogListSection;
  final PopularPostSection popularPostListSection;

  BlogModel({
    required this.id,
    required this.title,
    required this.description,
    this.rating,
    required this.blogImages,
    required this.blogListSection,
    required this.popularPostListSection,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      rating: json['rating']?.toDouble(),
      blogImages: List<String>.from(json['blogImages']),
      blogListSection:
      BlogListSection.fromJson(json['blogListSection']),
      popularPostListSection:
      PopularPostSection.fromJson(json['popularPostListSection']),
    );
  }
}
