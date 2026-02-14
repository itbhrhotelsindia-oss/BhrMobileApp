import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCities extends BookingEvent {}

class SelectCity extends BookingEvent {
  final String city;
  SelectCity(this.city);

  @override
  List<Object?> get props => [city];
}

class SelectHotel extends BookingEvent {
  final String hotelId;
  SelectHotel(this.hotelId);

  @override
  List<Object?> get props => [hotelId];
}

class SelectRoomType extends BookingEvent {
  final String roomTypeId;
  SelectRoomType(this.roomTypeId);

  @override
  List<Object?> get props => [roomTypeId];
}

class UpdateDates extends BookingEvent {
  final DateTime checkIn;
  final DateTime checkOut;

  UpdateDates(this.checkIn, this.checkOut);
}

class UpdateGuests extends BookingEvent {
  final int adults;
  final int children;
  final int rooms;

  UpdateGuests(this.adults, this.children, this.rooms);
}

class CheckAvailability extends BookingEvent {}

class SubmitBooking extends BookingEvent {
  final Map<String, dynamic> payload;
  SubmitBooking(this.payload);
}

class BookingSubmitted extends BookingEvent {}

class CreateRazorpayOrder extends BookingEvent {
  final String bookingId;
  CreateRazorpayOrder(this.bookingId);
}

class ClearPaymentOrder extends BookingEvent {}

class ResetAvailability extends BookingEvent {}

