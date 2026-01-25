class EventSliderModel {
  final List<String> images;
  final bool autoPlay;
  final int interval;

  EventSliderModel({
    required this.images,
    required this.autoPlay,
    required this.interval,
  });

  factory EventSliderModel.fromJson(Map<String, dynamic> json) {
    return EventSliderModel(
      images: List<String>.from(json['images']),
      autoPlay: json['autoPlay'] ?? false,
      interval: json['interval'] ?? 4000,
    );
  }
}
