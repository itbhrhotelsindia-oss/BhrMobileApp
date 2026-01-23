class LocationSection {
  final String mapEmbedUrl;
  final List<String> nearbyAttractions;

  LocationSection({
    required this.mapEmbedUrl,
    required this.nearbyAttractions,
  });

  factory LocationSection.fromJson(Map<String, dynamic> json) {
    return LocationSection(
      mapEmbedUrl: json['mapEmbedUrl'],
      nearbyAttractions:
      List<String>.from(json['nearbyAttractions'] ?? []),
    );
  }
}
