import 'faq_model.dart';
class FaqSection {
  final List<FaqModel> faqs;

  FaqSection({required this.faqs});

  factory FaqSection.fromJson(Map<String, dynamic> json) {
    return FaqSection(
      faqs: (json['faqs'] as List)
          .map((e) => FaqModel.fromJson(e))
          .toList(),
    );
  }
}
