import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/booking_state.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';

class BookingForm extends StatelessWidget {
  final BookingState state;

  const BookingForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value:
            state.selectedCity.isEmpty ? null : state.selectedCity,
            items: state.cities
                .map(
                  (c) => DropdownMenuItem(
                value: c.name,
                child: Text(c.name),
              ),
            )
                .toList(),
            onChanged: (v) {
              if (v != null) {
                context.read<BookingBloc>().add(SelectCity(v));
              }
            },
            hint: const Text("Select Place"),
          ),

          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              context.read<BookingBloc>().add(CheckAvailability());
            },
            child: const Text("Check Availability"),
          ),

          if (state.error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}

