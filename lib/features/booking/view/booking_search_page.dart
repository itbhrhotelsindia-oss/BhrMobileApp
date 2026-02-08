import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../booking/bloc/booking_bloc.dart';
import '../../booking/bloc/booking_state.dart';
import '../../booking/bloc/booking_event.dart';
import '../../booking/widgets/booking_availability.dart';
import '../../booking/widgets/booking_form.dart';
import '../../booking/repository/booking_repository.dart';


class BookingSearchPage extends StatelessWidget {
  const BookingSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(
        context.read<BookingRepository>(),
      )..add(LoadCities()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Reservations")),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// 🔹 BOOKING FORM (ALWAYS VISIBLE)
                  _bookingCard(context, state),

                  const SizedBox(height: 16),

                  /// 🔹 INFO CARD (ALWAYS VISIBLE)
                  // _infoCard(),

                  /// 🔹 LOADING
                  if (state.loading) ...[
                    const SizedBox(height: 24),
                    const Center(child: CircularProgressIndicator()),
                  ],

                  /// 🔹 AVAILABLE ROOMS (LIKE REACT)
                  if (state.showAvailability && state.availabilityData != null) ...[
                    const SizedBox(height: 24),
                    BookingAvailability(
                      availability: state.availabilityData,
                      search: {
                        "hotel": state.selectedHotelId,
                        "roomTypeName": state.selectedRoomType!.name,
                        "checkIn": state.checkIn!.toString().split(" ")[0],
                        "checkOut": state.checkOut!.toString().split(" ")[0],
                        "adults": state.adults,
                        "children": state.children,
                        "roomsRequested": state.rooms,
                        "pricePerNight": state.selectedRoomType!.basePrice,
                      },
                    ),
                  ],

                  /// 🔹 ERROR
                  if (state.error.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      state.error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            );
          },
        ),

      ),
    );
  }
}

Widget _bookingCard(BuildContext context, BookingState state) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _dropdown(
            label: "Place",
            value: state.selectedCity.isEmpty ? null : state.selectedCity,
            items: state.cities.map((c) => c.name).toList(),
            onChanged: (v) =>
                context.read<BookingBloc>().add(SelectCity(v)),
          ),
          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            value: state.selectedHotelId.isEmpty
                ? null
                : state.selectedHotelId,
            decoration: const InputDecoration(labelText: "Hotel"),
            items: state.hotels
                .map(
                  (h) => DropdownMenuItem(
                value: h.hotelId,
                child: Text(h.name),
              ),
            )
                .toList(),
            onChanged: state.hotels.isEmpty
                ? null // disabled until place selected
                : (v) {
              if (v != null) {
                context.read<BookingBloc>().add(SelectHotel(v));
              }
            },
          ),

          const SizedBox(height: 12),

          _dateField(
            context,
            label: "From",
            date: state.checkIn,
            onSelect: (d) =>
                context.read<BookingBloc>().add(UpdateDates(d, state.checkOut ?? d)),
          ),

          const SizedBox(height: 12),

          _dateField(
            context,
            label: "To",
            date: state.checkOut,
            onSelect: (d) =>
                context.read<BookingBloc>().add(UpdateDates(state.checkIn ?? d, d)),
          ),

          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            value: state.selectedRoomType?.id,
            decoration: const InputDecoration(labelText: "Room Type"),
            items: state.roomTypes
                .map(
                  (r) => DropdownMenuItem(
                value: r.id,
                child: Text("${r.name} (₹${r.basePrice})"),
              ),
            )
                .toList(),
            onChanged: state.roomTypes.isEmpty
                ? null
                : (v) {
              if (v != null) {
                context.read<BookingBloc>().add(SelectRoomType(v));
              }
            },
          ),


          const SizedBox(height: 12),

          Row(
            children: [
              _counter("Adults", state.adults, (v) {
                context.read<BookingBloc>().add(
                  UpdateGuests(v, state.children, state.rooms),
                );
              }),
              _counter("Children", state.children, (v) {
                context.read<BookingBloc>().add(
                  UpdateGuests(state.adults, v, state.rooms),
                );
              }),
              _counter("Rooms", state.rooms, (v) {
                context.read<BookingBloc>().add(
                  UpdateGuests(state.adults, state.children, v),
                );
              }),
            ],
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC9A24D),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () =>
                  context.read<BookingBloc>().add(CheckAvailability()),
              child: const Text(
                "Check Availability",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _infoCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFEFF6E5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Book now & pay directly at hotel",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Text("• Use Promocode WEB5PL – extra ₹500 off"),
        Text("• Early Bird: Extra 10% Off"),
        Text("• Last Minute Deal: Extra 5% Off"),
        Text("• Hourly Rooms Available"),
        Text("• Bathtub (Deluxe & Suite rooms)"),
      ],
    ),
  );
}


Widget _dropdown({
  required String label,
  required String? value,
  required List<String> items,
  required ValueChanged<String> onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    decoration: InputDecoration(labelText: label),
    items: items
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList(),
    onChanged: (v) {
      if (v != null) onChanged(v);
    },
  );
}

Widget _counter(String label, int value, ValueChanged<int> onChanged) {
  return Expanded(
    child: Column(
      children: [
        Text(label),
        TextFormField(
          initialValue: value.toString(),
          keyboardType: TextInputType.number,
          onChanged: (v) =>
              onChanged(int.tryParse(v) ?? value),
        ),
      ],
    ),
  );
}

Widget _dateField(
    BuildContext context, {
      required String label,
      required DateTime? date,
      required ValueChanged<DateTime> onSelect,
    }) {
  return TextFormField(
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: const Icon(Icons.calendar_today),
    ),
    controller: TextEditingController(
      text: date == null ? "" : date.toString().split(" ")[0],
    ),
    onTap: () async {
      final picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );
      if (picked != null) onSelect(picked);
    },
  );
}

