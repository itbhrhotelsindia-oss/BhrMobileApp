import 'package:flutter_bloc/flutter_bloc.dart';
import 'offers_event.dart';
import 'offers_state.dart';
import '../repository/offers_repository.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final OffersRepository repository;

  OffersBloc(this.repository) : super(OffersInitial()) {
    on<LoadOffers>(_load);
  }

  Future<void> _load(
      LoadOffers event,
      Emitter<OffersState> emit,
      ) async {
    emit(OffersLoading());

    try {
      final offers = await repository.loadOffers();
      emit(OffersLoaded(offers));
    } catch (e) {
      emit(OffersError("Failed to load offers"));
    }
  }
}
