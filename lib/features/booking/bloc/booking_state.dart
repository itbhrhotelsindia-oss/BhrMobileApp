import 'package:equatable/equatable.dart';
import '../model/room_type_model.dart';
import '../../our_hotels/model/city_model.dart';
import '../../our_hotels/model/hotel_model.dart';

class BookingState extends Equatable {
  final bool loading;
  final String error;

  final List<CityModel> cities;
  final List<HotelModel> hotels;
  final List<RoomTypeModel> roomTypes;

  final String selectedCity;
  final String selectedHotelId;
  final RoomTypeModel? selectedRoomType;

  final DateTime? checkIn;
  final DateTime? checkOut;

  final int adults;
  final int children;
  final int rooms;

  final bool showAvailability;
  final dynamic availabilityData;

  const BookingState({
    this.loading = false,
    this.error = "",
    this.cities = const [],
    this.hotels = const [],
    this.roomTypes = const [],
    this.selectedCity = "",
    this.selectedHotelId = "",
    this.selectedRoomType,
    this.checkIn,
    this.checkOut,
    this.adults = 1,
    this.children = 0,
    this.rooms = 1,
    this.showAvailability = false,
    this.availabilityData,
  });

  BookingState copyWith({
    bool? loading,
    String? error,
    List<CityModel>? cities,
    List<HotelModel>? hotels,
    List<RoomTypeModel>? roomTypes,
    String? selectedCity,
    String? selectedHotelId,
    RoomTypeModel? selectedRoomType,
    DateTime? checkIn,
    DateTime? checkOut,
    int? adults,
    int? children,
    int? rooms,
    bool? showAvailability,
    dynamic availabilityData,
  }) {
    return BookingState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      cities: cities ?? this.cities,
      hotels: hotels ?? this.hotels,
      roomTypes: roomTypes ?? this.roomTypes,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedHotelId: selectedHotelId ?? this.selectedHotelId,
      selectedRoomType: selectedRoomType ?? this.selectedRoomType,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      rooms: rooms ?? this.rooms,
      showAvailability: showAvailability ?? this.showAvailability,
      availabilityData: availabilityData ?? this.availabilityData,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    error,
    cities,
    hotels,
    roomTypes,
    selectedCity,
    selectedHotelId,
    selectedRoomType,
    checkIn,
    checkOut,
    adults,
    children,
    rooms,
    showAvailability,
    availabilityData,
  ];
}
