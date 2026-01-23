class HotelSlider {
  final String title;
  final String subtitle;
  final List<String> images;

  HotelSlider({
    required this.title,
    required this.subtitle,
    required this.images,
  });

  factory HotelSlider.fromJson(Map<String, dynamic> json) {
    return HotelSlider(
      title: json['title'],
      subtitle: json['subtitle'],
      images: List<String>.from(json['images'] ?? []),
    );
  }
}
