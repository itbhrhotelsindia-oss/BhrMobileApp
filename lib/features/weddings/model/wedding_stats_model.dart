class WeddingStatModel {
  final String value;
  final String label;

  WeddingStatModel({
    required this.value,
    required this.label,
  });

  factory WeddingStatModel.fromJson(Map<String, dynamic> json) {
    return WeddingStatModel(
      value: json['value']?.toString() ?? '',
      label: json['label'] ?? '',
    );
  }
}
