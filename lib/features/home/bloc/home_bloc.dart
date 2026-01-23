import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';
import '../repository/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc(this.repository) : super(const HomeState()) {
    on<LoadHomeEvent>(_onLoadHome);
  }

  Future<void> _onLoadHome(
      LoadHomeEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(loading: true));

    try {
      final data = await repository.loadHome();

      emit(
        state.copyWith(
          loading: false,
          data: data,
          error: null,
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
