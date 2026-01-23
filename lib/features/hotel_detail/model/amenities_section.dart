class AmenitiesSection {
  final String title;
  final List<String> amenities;

  AmenitiesSection({
    required this.title,
    required this.amenities,
  });

  factory AmenitiesSection.fromJson(Map<String, dynamic> json) {
    return AmenitiesSection(
      title: json['title'],
      amenities: List<String>.from(json['amenities'] ?? []),
    );
  }
}
