import 'about_section.dart';
import 'amenities_section.dart';
import 'basic_info.dart';
import 'faq_model.dart';
import 'faq_section.dart';
import 'gallery_section.dart';
import 'hotel_slider.dart';
import 'location_section.dart';
import 'policies_section.dart';
import 'room_model.dart';
import 'room_section.dart';

class HotelDetailModel {
  final String hotelId;
  final BasicInfo basicInfo;
  final HotelSlider hotelSlider;
  final List<String> services;
  final AboutSection aboutSection;
  final RoomsSection roomsSection;
  final AmenitiesSection amenitiesSection;
  final GallerySection gallerySection;
  final PoliciesSection policiesSection;
  final LocationSection locationSection;
  final FaqSection faqSection;
  final String status;

  HotelDetailModel({
    required this.hotelId,
    required this.basicInfo,
    required this.hotelSlider,
    required this.services,
    required this.aboutSection,
    required this.roomsSection,
    required this.amenitiesSection,
    required this.gallerySection,
    required this.policiesSection,
    required this.locationSection,
    required this.faqSection,
    required this.status,
  });

  factory HotelDetailModel.fromJson(Map<String, dynamic> json) {
    return HotelDetailModel(
      hotelId: json['hotelId'],
      basicInfo: BasicInfo.fromJson(json['basicInfo']),
      hotelSlider: HotelSlider.fromJson(json['hotelSlider']),
      services: List<String>.from(json['services'] ?? []),
      aboutSection: AboutSection.fromJson(json['aboutSection']),
      roomsSection: RoomsSection.fromJson(json['roomsSection']),
      amenitiesSection: AmenitiesSection.fromJson(json['amenitiesSection']),
      gallerySection: GallerySection.fromJson(json['gallerySection']),
      policiesSection: PoliciesSection.fromJson(json['policiesSection']),
      locationSection: LocationSection.fromJson(json['locationSection']),
      faqSection: FaqSection.fromJson(json['faqSection']),
      status: json['status'],
    );
  }
}
