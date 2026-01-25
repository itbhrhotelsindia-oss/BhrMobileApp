class PartnerFormModel {
  String companyName;
  String website;
  String fullName;
  String email;
  String contactNumber;
  String partnershipType;
  String location;
  String message;

  PartnerFormModel({
    this.companyName = "",
    this.website = "",
    this.fullName = "",
    this.email = "",
    this.contactNumber = "",
    this.partnershipType = "",
    this.location = "",
    this.message = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "companyName": companyName,
      "website": website,
      "fullName": fullName,
      "email": email,
      "contactNumber": contactNumber,
      "partnershipType": partnershipType,
      "location": location,
      "message": message,
    };
  }

  void reset() {
    companyName = "";
    website = "";
    fullName = "";
    email = "";
    contactNumber = "";
    partnershipType = "";
    location = "";
    message = "";
  }
}
