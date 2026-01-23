import 'package:flutter_bloc/flutter_bloc.dart';
import 'our_hotels_event.dart';
import 'our_hotels_state.dart';
import '../repository/our_hotels_repository.dart';

class OurHotelsBloc
    extends Bloc<OurHotelsEvent, OurHotelsState> {
  final OurHotelsRepository repository;

  OurHotelsBloc(this.repository)
      : super(const OurHotelsState()) {
    on<LoadOurHotels>(_load);
  }

  Future<void> _load(
      LoadOurHotels event,
      Emitter<OurHotelsState> emit,
      ) async {
    emit(state.copyWith(loading: true));

    try {
      final hotels = await repository.loadOurHotels();
      final cities = await repository.loadCities();

      emit(
        state.copyWith(
          loading: false,
          data: hotels,
          cities: cities,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loading: false,
          error: e.toString(),
        ),
      );
    }
  }
}
