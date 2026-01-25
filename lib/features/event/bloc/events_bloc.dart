import 'package:flutter_bloc/flutter_bloc.dart';

import 'events_event.dart';
import 'events_state.dart';
import '../repository/events_repository.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventsRepository repository;

  EventsBloc(this.repository) : super(EventsInitial()) {
    on<LoadEventsPage>(_loadPage);
    on<SubmitEventEnquiry>(_submitForm);
  }

  Future<void> _loadPage(
      LoadEventsPage event,
      Emitter<EventsState> emit,
      ) async {
    emit(EventsLoading());

    try {
      final page = await repository.loadEventsPage();
      final cities = await repository.loadCities();

      emit(
        EventsLoaded(
          data: page,
          cities: cities,
        ),
      );
    } catch (_) {
      emit(EventsError("Failed to load events"));
    }
  }


  Future<void> _submitForm(
      SubmitEventEnquiry event,
      Emitter<EventsState> emit,
      ) async {
    emit(EventsSubmitting());

    try {
      await repository.submitEnquiry(event.form);
      emit(EventsSuccess("Thank you! Our team will contact you shortly."));
    } catch (_) {
      emit(EventsError("Something went wrong"));
    }
  }

}
