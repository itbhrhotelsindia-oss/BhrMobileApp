import 'package:equatable/equatable.dart';
import '../models/home_model.dart';

class HomeState extends Equatable {
  final bool loading;
  final HomeModel? data;
  final String? error;

  const HomeState({
    this.loading = false,
    this.data,
    this.error,
  });

  HomeState copyWith({
    bool? loading,
    HomeModel? data,
    String? error,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, data, error];
}
