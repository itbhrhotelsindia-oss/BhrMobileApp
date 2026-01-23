import 'hotel_model.dart';

class CityModel {
  final String id;
  final String name;
  final String state;
  final String cityImageUrl;
  final List<HotelModel> hotels;

  CityModel({
    required this.id,
    required this.name,
    required this.state,
    required this.cityImageUrl,
    required this.hotels,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      state: json['state'] ?? '',
      cityImageUrl: json['cityImageUrl'] ?? '',
      hotels: (json['hotels'] as List? ?? [])
          .map((e) => HotelModel.fromJson(e))
          .toList(),
    );
  }
}
