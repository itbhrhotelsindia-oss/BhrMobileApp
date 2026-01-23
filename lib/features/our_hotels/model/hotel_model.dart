class HotelModel {
  final String hotelId;
  final String city;
  final String name;
  final String address;
  final String imageUrl;
  final List<String> services;

  HotelModel({
    required this.hotelId,
    required this.city,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.services,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      hotelId: json['hotelId'] ?? '',
      city: json['city'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      services: (json['services'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
