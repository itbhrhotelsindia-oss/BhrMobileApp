class BlogDetailModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String htmlContent;
  final String? slug;
  final String? author;
  final String? date;

  BlogDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.htmlContent,
    this.slug,
    this.author,
    this.date,
  });
}
