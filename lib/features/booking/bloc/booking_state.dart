import '../model/booking_data.dart';

class BookingState {
  final BookingData data;
  final bool loading;
  final String? redirectUrl;
  final String? error;

  const BookingState({
    this.data = const BookingData(),
    this.loading = false,
    this.redirectUrl,
    this.error,
  });

  BookingState copyWith({
    BookingData? data,
    bool? loading,
    String? redirectUrl,
    String? error,
  }) {
    return BookingState(
      data: data ?? this.data,
      loading: loading ?? this.loading,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      error: error ?? this.error,
    );
  }
}
