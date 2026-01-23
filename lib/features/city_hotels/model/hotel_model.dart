class HotelModel {
  final String id;
  final String name;
  final String city;
  final String image;
  final String slug;

  HotelModel({
    required this.id,
    required this.name,
    required this.city,
    required this.image,
    required this.slug,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      image: json['image'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}
