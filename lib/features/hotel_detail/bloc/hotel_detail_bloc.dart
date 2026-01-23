import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/hotel_detail_repository.dart';
import 'hotel_detail_event.dart';
import 'hotel_detail_state.dart';

class HotelDetailBloc
    extends Bloc<HotelDetailEvent, HotelDetailState> {
  final HotelDetailRepository repo;

  HotelDetailBloc(this.repo) : super(HotelDetailInitial()) {
    on<LoadHotelDetail>((event, emit) async {
      emit(HotelDetailLoading());

      try {
        final hotel = await repo.loadHotel(event.hotelId);
        emit(HotelDetailLoaded(hotel));
      } catch (e) {
        emit(HotelDetailError("Failed to load hotel"));
      }
    });
  }
}
