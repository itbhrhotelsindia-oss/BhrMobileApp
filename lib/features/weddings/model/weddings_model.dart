import 'wedding_stats_model.dart';
import 'festivities_model.dart';
import 'type_of_wedding_model.dart';

class WeddingModel {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final List<WeddingStatModel> stats;
  final FestivitiesModel festivities;
  final TypeOfWeddingModel typeOfWeddings;

  WeddingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.stats,
    required this.festivities,
    required this.typeOfWeddings,
  });

  factory WeddingModel.fromJson(Map<String, dynamic> json) {
    return WeddingModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      stats: (json['stats'] as List? ?? [])
          .map((e) => WeddingStatModel.fromJson(e))
          .toList(),
      festivities: FestivitiesModel.fromJson(json['festivities']),
      typeOfWeddings:
      TypeOfWeddingModel.fromJson(json['typeOfWeddings']),
    );
  }
}

