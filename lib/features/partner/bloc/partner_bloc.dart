import 'package:flutter_bloc/flutter_bloc.dart';
import 'partner_event.dart';
import 'partner_state.dart';
import '../repository/partner_repository.dart';

class PartnerBloc extends Bloc<PartnerEvent, PartnerState> {
  final PartnerRepository repository;

  PartnerBloc(this.repository) : super(PartnerInitial()) {
    on<LoadCities>(_loadCities);
    on<SubmitPartnerForm>(_submit);
  }

  Future<void> _loadCities(
      LoadCities event,
      Emitter emit,
      ) async {
    emit(PartnerLoading());
    try {
      final cities = await repository.loadCities();
      emit(CitiesLoaded(cities));
    } catch (_) {
      emit(PartnerError("Failed to load cities"));
    }
  }

  Future<void> _submit(
      SubmitPartnerForm event,
      Emitter emit,
      ) async {
    emit(PartnerSubmitting());
    try {
      await repository.submitForm(event.form);
      emit(PartnerSuccess(
          "Thank you! Our team will contact you shortly."));
    } catch (_) {
      emit(PartnerError("Submission failed. Try again."));
    }
  }
}
