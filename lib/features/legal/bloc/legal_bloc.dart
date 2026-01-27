import 'package:flutter_bloc/flutter_bloc.dart';
import 'legal_event.dart';
import 'legal_state.dart';
import '../repository/legal_repository.dart';

class LegalBloc extends Bloc<LegalEvent, LegalState> {
  final LegalRepository repository;

  LegalBloc(this.repository) : super(LegalInitial()) {
    on<LoadLegalPage>(_load);
  }

  Future<void> _load(
      LoadLegalPage event,
      Emitter<LegalState> emit,
      ) async {
    emit(LegalLoading());

    try {
      final data =
      await repository.loadLegalPage(event.apiPath);

      emit(LegalLoaded(data));
    } catch (e) {
      emit(
        LegalError("Unable to load content. Please try again later."),
      );
    }
  }
}
