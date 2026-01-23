import '../model/hotel_detail_model.dart';

abstract class HotelDetailState {}

class HotelDetailInitial extends HotelDetailState {}

class HotelDetailLoading extends HotelDetailState {}

class HotelDetailLoaded extends HotelDetailState {
  final HotelDetailModel hotel;

  HotelDetailLoaded(this.hotel);
}

class HotelDetailError extends HotelDetailState {
  final String message;

  HotelDetailError(this.message);
}
