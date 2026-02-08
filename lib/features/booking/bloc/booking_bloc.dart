import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_event.dart';
import 'booking_state.dart';
import '../repository/booking_repository.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repo;

  BookingBloc(this.repo) : super(const BookingState()) {
    on<LoadCities>(_loadCities);
    on<SelectCity>(_selectCity);
    on<SelectHotel>(_selectHotel);
    on<SelectRoomType>(_selectRoomType);
    on<UpdateDates>(_updateDates);
    on<UpdateGuests>(_updateGuests);
    on<CheckAvailability>(_checkAvailability);
    on<SubmitBooking>(_submitBooking);
    on<CreateRazorpayOrder>(_createRazorpayOrder);
    on<ClearPaymentOrder>((event, emit) {
      emit(state.copyWith(paymentOrder: null));
    });

  }

  Future<void> _loadCities(
      LoadCities event, Emitter<BookingState> emit) async {
    emit(state.copyWith(loading: true));
    final cities = await repo.getCities();
    emit(state.copyWith(loading: false, cities: cities));
  }

  void _selectCity(SelectCity event, Emitter<BookingState> emit) {
    final city = state.cities.firstWhere(
          (c) => c.name == event.city,
    );
    emit(state.copyWith(
      selectedCity: event.city,
      hotels: city.hotels,
      selectedHotelId: "",
      roomTypes: [],
    ));
  }

  Future<void> _selectHotel(
      SelectHotel event, Emitter<BookingState> emit) async {
    emit(state.copyWith(loading: true));
    final roomTypes = await repo.getRoomTypes(event.hotelId);
    emit(state.copyWith(
      loading: false,
      selectedHotelId: event.hotelId,
      roomTypes: roomTypes,
    ));
  }

  void _selectRoomType(
      SelectRoomType event, Emitter<BookingState> emit) {
    final rt =
    state.roomTypes.firstWhere((r) => r.id == event.roomTypeId);
    emit(state.copyWith(selectedRoomType: rt));
  }

  void _updateDates(UpdateDates event, Emitter<BookingState> emit) {
    emit(state.copyWith(
      checkIn: event.checkIn,
      checkOut: event.checkOut,
    ));
  }

  void _updateGuests(UpdateGuests event, Emitter<BookingState> emit) {
    emit(state.copyWith(
      adults: event.adults,
      children: event.children,
      rooms: event.rooms,
    ));
  }

  Future<void> _checkAvailability(
      CheckAvailability event, Emitter<BookingState> emit) async {
    emit(state.copyWith(loading: true, error: ""));
    try {
      final data = await repo.checkAvailability(state);
      emit(state.copyWith(
        loading: false,
        showAvailability: true,
        availabilityData: data,
      ));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        error: "Rooms not available",
      ));
    }
  }

  Future<void> _submitBooking(
      SubmitBooking event,
      Emitter<BookingState> emit,
      ) async {
    emit(state.copyWith(
      submittingBooking: true,
      error: "",
    ));

    try {
      final booking =
      await repo.createBooking(event.payload);

      emit(state.copyWith(
        submittingBooking: false,
        confirmedBooking: booking,
      ));
    } catch (e) {
      emit(state.copyWith(
        submittingBooking: false,
        error: "Unable to create booking",
      ));
    }
  }

  Future<void> _createRazorpayOrder(
      CreateRazorpayOrder event,
      Emitter<BookingState> emit,
      ) async {
    emit(state.copyWith(
      creatingPayment: true,
      error: "",
    ));

    try {
      final order =
      await repo.createRazorpayOrder(event.bookingId);

      emit(state.copyWith(
        creatingPayment: false,
        paymentOrder: order,
      ));
    } catch (e) {
      emit(state.copyWith(
        creatingPayment: false,
        error: "PAYMENT_ORDER_FAILED",
      ));
    }
  }

}