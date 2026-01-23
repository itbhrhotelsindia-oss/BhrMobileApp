class BasicInfo {
  final String name;
  final String city;
  final String state;
  final String address;

  BasicInfo({
    required this.name,
    required this.city,
    required this.state,
    required this.address,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> json) {
    return BasicInfo(
      name: json['name'],
      city: json['city'],
      state: json['state'],
      address: json['address'],
    );
  }
}
