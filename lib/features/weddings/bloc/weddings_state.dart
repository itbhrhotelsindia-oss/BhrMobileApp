import '../../weddings/model/weddings_model.dart';

abstract class WeddingsState {}

class WeddingsLoading extends WeddingsState {}

class WeddingsLoaded extends WeddingsState {
  final WeddingModel data;
  WeddingsLoaded(this.data);
}

class WeddingsError extends WeddingsState {
  final String message;
  WeddingsError(this.message);
}
