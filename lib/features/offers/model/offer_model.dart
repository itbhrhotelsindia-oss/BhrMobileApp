class OfferModel {
  final String id;
  final String title;
  final String desc;
  final String img;
  final String validity;
  final String loginBtn;

  OfferModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.img,
    required this.validity,
    required this.loginBtn,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      img: json['img'] ?? '',
      validity: json['validity'] ?? '',
      loginBtn: json['loginBtn'] ?? 'BOOK NOW',
    );
  }
}
