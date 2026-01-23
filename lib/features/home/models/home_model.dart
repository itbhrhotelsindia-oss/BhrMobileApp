class HomeModel {
  final List<String> heroImages;
  final BrandSection brandSection;
  final EventsSectionModel eventsSection;
  final BrandBanner brandBanner;
  final ContactSection contact;

  HomeModel({
    required this.heroImages,
    required this.brandSection,
    required this.eventsSection,
    required this.brandBanner,
    required this.contact,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      heroImages:
      List<String>.from(json['heroImages'] ?? []),

      brandSection:
      BrandSection.fromJson(json['brandSection'] ?? {}),

      eventsSection:
      EventsSectionModel.fromJson(
          json['eventsSection'] ?? {}),

      brandBanner:
      BrandBanner.fromJson(json['brandBanner'] ?? {}),

      contact:
      ContactSection.fromJson(
          json['contactSection'] ?? {}),
    );
  }
}

/* =====================================================
   BRAND SECTION
===================================================== */

class BrandSection {
  final String title;
  final List<BrandBlock> blocks;

  BrandSection({
    required this.title,
    required this.blocks,
  });

  factory BrandSection.fromJson(Map<String, dynamic> json) {
    return BrandSection(
      title: json['title'] ?? '',
      blocks: (json['blocks'] as List? ?? [])
          .map((e) => BrandBlock.fromJson(e))
          .toList(),
    );
  }
}

class BrandBlock {
  final String text;
  final String imageUrl;

  BrandBlock({
    required this.text,
    required this.imageUrl,
  });

  factory BrandBlock.fromJson(Map<String, dynamic> json) {
    return BrandBlock(
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}

/* =====================================================
   EVENTS SECTION
===================================================== */

class EventsSectionModel {
  final String title;
  final String description;
  final List<EventItem> events;

  EventsSectionModel({
    required this.title,
    required this.description,
    required this.events,
  });

  factory EventsSectionModel.fromJson(
      Map<String, dynamic> json) {
    return EventsSectionModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      events: (json['events'] as List? ?? [])
          .map((e) => EventItem.fromJson(e))
          .toList(),
    );
  }
}

class EventItem {
  final String title;
  final String imageUrl;
  final String description;

  EventItem({
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

/* =====================================================
   BRAND BANNER
===================================================== */

class BrandBanner {
  final String title;
  final String subtitle;
  final List<BannerContact> contacts;

  BrandBanner({
    required this.title,
    required this.subtitle,
    required this.contacts,
  });

  factory BrandBanner.fromJson(Map<String, dynamic> json) {
    return BrandBanner(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      contacts: (json['contacts'] as List? ?? [])
          .map((e) => BannerContact.fromJson(e))
          .toList(),
    );
  }
}

class BannerContact {
  final String type;
  final String value;
  final String displayValue;

  BannerContact({
    required this.type,
    required this.value,
    required this.displayValue,
  });

  factory BannerContact.fromJson(Map<String, dynamic> json) {
    return BannerContact(
      type: json['type'] ?? '',
      value: json['value'] ?? '',
      displayValue: json['displayValue'] ?? '',
    );
  }
}

/* =====================================================
   CONTACT SECTION
===================================================== */

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
