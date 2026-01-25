import '../model/city_model.dart';

abstract class PartnerState {}

class PartnerInitial extends PartnerState {}

class PartnerLoading extends PartnerState {}

class CitiesLoaded extends PartnerState {
  final List<CityModel> cities;
  CitiesLoaded(this.cities);
}

class PartnerSubmitting extends PartnerState {}

class PartnerSuccess extends PartnerState {
  final String message;
  PartnerSuccess(this.message);
}

class PartnerError extends PartnerState {
  final String message;
  PartnerError(this.message);
}
