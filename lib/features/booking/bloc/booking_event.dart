abstract class BookingEvent {}

class SubmitBooking extends BookingEvent {}

class UpdateRooms extends BookingEvent {
  final int value;
  UpdateRooms(this.value);
}

class UpdateAdults extends BookingEvent {
  final int value;
  UpdateAdults(this.value);
}

class UpdateChildren extends BookingEvent {
  final int value;
  UpdateChildren(this.value);
}

class UpdateDates extends BookingEvent {
  final DateTime checkIn;
  final DateTime checkOut;

  UpdateDates(this.checkIn, this.checkOut);
}