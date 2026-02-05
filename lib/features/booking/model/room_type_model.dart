class RoomTypeModel {
  final String id;
  final String hotelId;
  final String name;
  final String description;
  final int maxAdults;
  final int maxChildren;
  final int maxGuests;
  final double basePrice;
  final DateTime createdAt;
  final bool active;

  RoomTypeModel({
    required this.id,
    required this.hotelId,
    required this.name,
    required this.description,
    required this.maxAdults,
    required this.maxChildren,
    required this.maxGuests,
    required this.basePrice,
    required this.createdAt,
    required this.active,
  });

  /// ---------------- FROM JSON ----------------
  factory RoomTypeModel.fromJson(Map<String, dynamic> json) {
    return RoomTypeModel(
      id: json['id'] ?? '',
      hotelId: json['hotelId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      maxAdults: json['maxAdults'] ?? 0,
      maxChildren: json['maxChildren'] ?? 0,
      maxGuests: json['maxGuests'] ?? 0,
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      active: json['active'] ?? false,
    );
  }

  /// ---------------- TO JSON ----------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hotelId': hotelId,
      'name': name,
      'description': description,
      'maxAdults': maxAdults,
      'maxChildren': maxChildren,
      'maxGuests': maxGuests,
      'basePrice': basePrice,
      'createdAt': createdAt.toIso8601String(),
      'active': active,
    };
  }
}
