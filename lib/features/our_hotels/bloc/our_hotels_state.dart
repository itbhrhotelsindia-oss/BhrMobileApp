import '../model/city_model.dart';
import '../model/our_hotels_model.dart';

class OurHotelsState {
  final bool loading;
  final OurHotelsModel? data;
  final List<CityModel> cities;
  final String? error;

  const OurHotelsState({
    this.loading = false,
    this.data,
    this.cities = const [],
    this.error,
  });

  OurHotelsState copyWith({
    bool? loading,
    OurHotelsModel? data,
    List<CityModel>? cities,
    String? error,
  }) {
    return OurHotelsState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      cities: cities ?? this.cities,
      error: error,
    );
  }
}
