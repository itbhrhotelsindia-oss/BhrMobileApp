import 'package:flutter_bloc/flutter_bloc.dart';

import 'header_event.dart';
import 'header_state.dart';
import '../repository/header_repository.dart';

class HeaderBloc extends Bloc<HeaderEvent, HeaderState> {
  final HeaderRepository repository;

  HeaderBloc(this.repository) : super(HeaderState()) {
    on<LoadCities>(_loadCities);
  }

  Future<void> _loadCities(
      LoadCities event,
      Emitter<HeaderState> emit,
      ) async {
    emit(state.copyWith(loading: true));

    final cities = await repository.fetchCities();

    emit(
      state.copyWith(
        loading: false,
        cities: cities,
      ),
    );
  }
}
