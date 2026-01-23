import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/weddings_repository.dart';
import '../../weddings/model/weddings_model.dart';
import 'weddings_event.dart';
import 'weddings_state.dart';

class WeddingsBloc extends Bloc<WeddingsEvent, WeddingsState> {
  final WeddingsRepository repository;

  WeddingsBloc(this.repository) : super(WeddingsLoading()) {
    on<LoadWeddings>((event, emit) async {
      try {
        final data = await repository.loadWeddings();
        emit(WeddingsLoaded(data));
      } catch (e) {
        emit(WeddingsError(e.toString()));
      }
    });
  }
}
