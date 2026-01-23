import '../model/city_model.dart';

class HeaderState {
  final bool loading;
  final List<CityModel> cities;

  HeaderState({
    this.loading = false,
    this.cities = const [],
  });

  HeaderState copyWith({
    bool? loading,
    List<CityModel>? cities,
  }) {
    return HeaderState(
      loading: loading ?? this.loading,
      cities: cities ?? this.cities,
    );
  }
}
