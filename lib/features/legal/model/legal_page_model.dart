import 'legal_section_model.dart';

class LegalPageModel {
  final String? slug;
  final String title;
  final String? lastUpdated;
  final List<LegalSectionModel> content;

  LegalPageModel({
    this.slug,
    required this.title,
    this.lastUpdated,
    required this.content,
  });

  factory LegalPageModel.fromJson(Map<String, dynamic> json) {
    return LegalPageModel(
      slug: json['slug'] ?? '',
      title: json['title'] ?? '',
      lastUpdated: json['lastUpdated'],
      content: (json['content'] as List)
          .map((e) => LegalSectionModel.fromJson(e))
          .toList(),
    );
  }
}
