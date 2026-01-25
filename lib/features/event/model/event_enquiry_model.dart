class EventEnquiryModel {
  final String name;
  final String email;
  final String phone;
  final String eventType;
  final String location;
  final String query;
  final String category;

  EventEnquiryModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.eventType,
    required this.location,
    required this.query,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      "pageId": "EVENTS-PAGE-001",
      "category": category,
      "name": name,
      "email": email,
      "phone": phone,
      "eventType": eventType,
      "location": location,
      "query": query,
    };
  }
}
