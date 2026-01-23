import 'room_model.dart';
class RoomsSection {
  final String title;
  final List<RoomModel> rooms;

  RoomsSection({
    required this.title,
    required this.rooms,
  });

  factory RoomsSection.fromJson(Map<String, dynamic> json) {
    return RoomsSection(
      title: json['title'],
      rooms: (json['rooms'] as List)
          .map((e) => RoomModel.fromJson(e))
          .toList(),
    );
  }
}
