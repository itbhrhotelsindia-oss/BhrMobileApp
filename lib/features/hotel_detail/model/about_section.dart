class AboutSection {
  final String title;
  final String description;

  AboutSection({
    required this.title,
    required this.description,
  });

  factory AboutSection.fromJson(Map<String, dynamic> json) {
    return AboutSection(
      title: json['title'],
      description: json['description'],
    );
  }
}
