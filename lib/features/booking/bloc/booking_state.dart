import 'package:equatable/equatable.dart';
import '../model/room_type_model.dart';
import '../../our_hotels/model/city_model.dart';
import '../../our_hotels/model/hotel_model.dart';

class BookingState extends Equatable {
  final bool loading;
  final String error;
  final bool creatingPayment;
  final Map<String, dynamic>? paymentOrder;

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

  final bool submittingBooking;
  final Map<String, dynamic>? confirmedBooking;


  const BookingState({
    this.loading = false,
    this.submittingBooking = false,
    this.confirmedBooking,
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
    this.creatingPayment = false,
    this.paymentOrder,
  });

  BookingState copyWith({
    bool? loading,
    bool? submittingBooking,
    Map<String, dynamic>? confirmedBooking,
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
    bool? creatingPayment,
    Map<String, dynamic>? paymentOrder,
  }) {
    return BookingState(
      loading: loading ?? this.loading,
      submittingBooking: submittingBooking ?? this.submittingBooking,
      confirmedBooking: confirmedBooking ?? this.confirmedBooking,
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
      creatingPayment: creatingPayment ?? this.creatingPayment,
      paymentOrder: paymentOrder ?? this.paymentOrder,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    submittingBooking,
    confirmedBooking,
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
    creatingPayment,
    paymentOrder,
  ];
}
