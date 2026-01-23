class BookingData {
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int rooms;
  final int adults;
  final int children;

  const BookingData({
    this.checkIn,
    this.checkOut,
    this.rooms = 1,
    this.adults = 2,
    this.children = 0,
  });

  BookingData copyWith({
    DateTime? checkIn,
    DateTime? checkOut,
    int? rooms,
    int? adults,
    int? children,
  }) {
    return BookingData(
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      rooms: rooms ?? this.rooms,
      adults: adults ?? this.adults,
      children: children ?? this.children,
    );
  }
}
