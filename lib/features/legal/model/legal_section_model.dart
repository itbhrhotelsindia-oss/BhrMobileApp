class LegalSectionModel {
  final String heading;
  final String body;

  LegalSectionModel({
    required this.heading,
    required this.body,
  });

  factory LegalSectionModel.fromJson(Map<String, dynamic> json) {
    return LegalSectionModel(
      heading: json['heading'] ?? '',
      body: json['body'] ?? '',
    );
  }
}
