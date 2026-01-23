class OurHotelsModel {
  final String title;
  final String text;

  OurHotelsModel({
    required this.title,
    required this.text,
  });

  factory OurHotelsModel.fromJson(Map<String, dynamic> json) {
    return OurHotelsModel(
      title: json['title'],
      text: json['text'],
    );
  }
}
