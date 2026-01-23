import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(const BookingState()) {
    on<UpdateRooms>((e, emit) {
      emit(
        state.copyWith(
          data: state.data.copyWith(rooms: e.value),
        ),
      );
    });

    on<UpdateAdults>((e, emit) {
      emit(
        state.copyWith(
          data: state.data.copyWith(adults: e.value),
        ),
      );
    });

    on<UpdateChildren>((e, emit) {
      emit(
        state.copyWith(
          data: state.data.copyWith(children: e.value),
        ),
      );
    });

    on<UpdateDates>((e, emit) {
      emit(
        state.copyWith(
          data: state.data.copyWith(
            checkIn: e.checkIn,
            checkOut: e.checkOut,
          ),
        ),
      );
    });

    on<SubmitBooking>(_submit);
  }

  Future<void> _submit(
      SubmitBooking event,
      Emitter<BookingState> emit,
      ) async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(seconds: 2));

    emit(
      state.copyWith(
        loading: false,
        redirectUrl: "https://example.com/payment",
      ),
    );
  }
}
