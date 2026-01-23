abstract class HotelDetailEvent {}

class LoadHotelDetail extends HotelDetailEvent {
  final String hotelId;

  LoadHotelDetail(this.hotelId);
}
