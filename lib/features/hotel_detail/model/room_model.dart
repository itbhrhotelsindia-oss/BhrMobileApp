class RoomModel {
  final String roomTypeId;
  final String name;
  final String description;
  final List<String> images;
  final List<String> amenities;

  RoomModel({
    required this.roomTypeId,
    required this.name,
    required this.description,
    required this.images,
    required this.amenities,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomTypeId: json['roomTypeId'],
      name: json['name'],
      description: json['description'],
      images: List<String>.from(json['images'] ?? []),
      amenities: List<String>.from(json['amenities'] ?? []),
    );
  }
}
