class ContactSection {
  final String? companyName;
  final String? email;
  final String? reservationPhone;
  final String? corporateAddress;

  ContactSection({
    this.companyName,
    this.email,
    this.reservationPhone,
    this.corporateAddress,
  });

  factory ContactSection.fromJson(Map<String, dynamic> json) {
    return ContactSection(
      companyName: json['companyName'],
      email: json['email'],
      reservationPhone: json['reservationPhone'],
      corporateAddress: json['corporateAddress'],
    );
  }
}
