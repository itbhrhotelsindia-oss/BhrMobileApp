import '../model/legal_page_model.dart';

abstract class LegalState {}

class LegalInitial extends LegalState {}

class LegalLoading extends LegalState {}

class LegalLoaded extends LegalState {
  final LegalPageModel data;

  LegalLoaded(this.data);
}

class LegalError extends LegalState {
  final String message;

  LegalError(this.message);
}
