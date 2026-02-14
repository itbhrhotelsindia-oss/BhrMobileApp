import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../booking/bloc/booking_bloc.dart';
import '../../booking/bloc/booking_state.dart';
import '../../booking/bloc/booking_event.dart';
import '../../booking/widgets/booking_availability.dart';
import '../../booking/widgets/booking_form.dart';
import '../../booking/repository/booking_repository.dart';
import '../../../core/theme/app_colors.dart';
import '../../our_hotels/model/city_model.dart';

class BookingSearchPage extends StatelessWidget {
  final CityModel? cityModel;
  final String? hotelId;

  const BookingSearchPage({super.key, this.cityModel, this.hotelId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingBloc(context.read<BookingRepository>())..add(LoadCities()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Reservations")),
        body: BlocListener<BookingBloc, BookingState>(
          listenWhen: (previous, current) =>
              previous.cities != current.cities ||
              previous.hotels != current.hotels,
          listener: (context, state) {
            /// 🔹 Auto Select City
            if (cityModel != null &&
                state.cities.isNotEmpty &&
                state.selectedCity.isEmpty) {
              context.read<BookingBloc>().add(SelectCity(cityModel!.name));
            }

            /// 🔹 Auto Select Hotel (FIRST HOTEL)
            if (state.selectedCity.isNotEmpty &&
                state.hotels.isNotEmpty &&
                state.selectedHotelId.isEmpty) {
              final hotelToSelect = hotelId ??
                  state.hotels.first.hotelId;
              context.read<BookingBloc>().add(
                SelectHotel(hotelToSelect),
              );
            }
          },
          child: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// 🔹 BOOKING FORM
                    _bookingCard(context, state),

                    const SizedBox(height: 16),

                    /// 🔹 LOADING
                    if (state.loading) ...[
                      const SizedBox(height: 24),
                      const Center(child: CircularProgressIndicator()),
                    ],

                    /// 🔹 AVAILABLE ROOMS
                    if (state.showAvailability &&
                        state.availabilityData != null) ...[
                      const SizedBox(height: 24),

                      if (state.availabilityData["available"] == false) ...[
                        const SizedBox(height: 12),
                        Text(
                          state.availabilityData["message"] ??
                              "Rooms not available",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ] else ...[
                        BookingAvailability(
                          availability: state.availabilityData,
                          search: {
                            "hotel": state.selectedHotelId,
                            "roomTypeName": state.selectedRoomType!.name,
                            "checkIn": state.checkIn!.toString().split(" ")[0],
                            "checkOut": state.checkOut!.toString().split(
                              " ",
                            )[0],
                            "adults": state.adults,
                            "children": state.children,
                            "roomsRequested": state.rooms,
                            "pricePerNight": state.selectedRoomType!.basePrice,
                          },
                        ),
                      ],
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
      ),
    );
  }
}

Widget _bookingCard(BuildContext context, BookingState state) {
  final roomSelected = state.selectedRoomType != null;
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _dropdown(
            label: "Place",
            value: state.selectedCity.isEmpty ? null : state.selectedCity,
            items: state.cities.map((c) => c.name).toList(),
            onChanged: (v) => context.read<BookingBloc>().add(SelectCity(v)),
          ),
          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            value: state.selectedHotelId.isEmpty ? null : state.selectedHotelId,
            decoration: const InputDecoration(labelText: "Hotel"),
            items: state.hotels
                .map(
                  (h) =>
                      DropdownMenuItem(value: h.hotelId, child: Text(h.name)),
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

          // _dateField(
          //   context,
          //   label: "From",
          //   date: state.checkIn,
          //   onSelect: (d) =>
          //       context.read<BookingBloc>().add(UpdateDates(d, state.checkOut ?? d)),
          // ),
          _dateField(
            context,
            label: "From",
            date: state.checkIn ?? _today(),
            firstDate: _today(),
            onSelect: (d) {
              final checkIn = DateTime(d.year, d.month, d.day);
              final checkOut = checkIn.add(const Duration(days: 1));

              context.read<BookingBloc>().add(UpdateDates(checkIn, checkOut));
            },
          ),

          const SizedBox(height: 12),

          // _dateField(
          //   context,
          //   label: "To",
          //   date: state.checkOut,
          //   onSelect: (d) =>
          //       context.read<BookingBloc>().add(UpdateDates(state.checkIn ?? d, d)),
          // ),
          _dateField(
            context,
            label: "To",
            date: state.checkOut ?? _tomorrow(),
            firstDate: (state.checkIn ?? _today()).add(const Duration(days: 1)),
            onSelect: (d) {
              context.read<BookingBloc>().add(
                UpdateDates(
                  state.checkIn ?? _today(),
                  DateTime(d.year, d.month, d.day),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            value: state.selectedRoomType?.id,
            decoration: const InputDecoration(labelText: "Room Type"),
            items: state.roomTypes
                .map(
                  (r) => DropdownMenuItem(
                    value: r.id,
                    child: Text(
                      // "${r.name} (₹${r.basePrice})",
                      // "${r.name} (₹${r.basePrice})".length > 30 ? '${"${r.name} (₹${r.basePrice})".substring(0, 30)}...' : "${r.name} (₹${r.basePrice})",
                      "${r.name} ".length > 30
                          ? '${"${r.name} ".substring(0, 30)}...'
                          : "${r.name}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
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

          if (state.selectedRoomType != null) ...[
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.darkGold1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Text(
                    "Price:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "₹${state.selectedRoomType!.basePrice} / night",
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.darkGold1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Text(
                    "Max Guests:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state.selectedRoomType!.maxAdults} adults"
                          "${state.selectedRoomType!.maxChildren > 0 ? " and ${state.selectedRoomType!.maxChildren} children" : ""}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "per room",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 20),

          Row(
            children: [
              _counter(
                "Adults",
                state.adults,
                (v) {
                  context.read<BookingBloc>().add(
                    UpdateGuests(v, state.children, state.rooms),
                  );
                },
                min: 1,
                max: roomSelected
                    ? state.selectedRoomType!.maxAdults * state.rooms
                    : 1,
                enabled: roomSelected,
              ),

              _counter(
                "Children",
                state.children,
                (v) {
                  context.read<BookingBloc>().add(
                    UpdateGuests(state.adults, v, state.rooms),
                  );
                },
                min: 0,
                max: roomSelected
                    ? state.selectedRoomType!.maxChildren * state.rooms
                    : 0,
                enabled: roomSelected,
              ),

              _counter(
                "Rooms",
                state.rooms,
                (v) {
                  context.read<BookingBloc>().add(
                    UpdateGuests(state.adults, state.children, v),
                  );
                },
                min: 1,
                enabled: roomSelected,
              ),
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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

// Widget _counter(String label, int value, ValueChanged<int> onChanged) {
//   return Expanded(
//     child: Column(
//       children: [
//         Text(label),
//         TextFormField(
//           initialValue: value.toString(),
//           keyboardType: TextInputType.number,
//           onChanged: (v) =>
//               onChanged(int.tryParse(v) ?? value),
//         ),
//       ],
//     ),
//   );
// }

Widget _counter(
  String label,
  int value,
  ValueChanged<int> onChanged, {
  int min = 0,
  int? max,
  bool enabled = true, // ✅ NEW
}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: enabled ? Colors.black : Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color: enabled ? Colors.grey.shade300 : Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(8),
            color: enabled ? Colors.white : Colors.grey.shade100,
          ),
          child: Row(
            children: [
              /// MINUS BUTTON
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: enabled && value > min
                    ? () => onChanged(value - 1)
                    : null,
              ),

              /// VALUE
              Expanded(
                child: Center(
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: enabled ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),

              /// PLUS BUTTON
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: enabled && (max == null || value < max)
                    ? () => onChanged(value + 1)
                    : null,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _dateField(
  BuildContext context, {
  required String label,
  required DateTime date,
  required DateTime firstDate,
  required ValueChanged<DateTime> onSelect,
}) {
  return TextFormField(
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: const Icon(Icons.calendar_today),
    ),
    controller: TextEditingController(
      text:
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    ),
    onTap: () async {
      final picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: firstDate,
        lastDate: _today().add(const Duration(days: 365)),
      );

      if (picked != null) {
        onSelect(picked);
      }
    },
  );
}

DateTime _today() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

DateTime _tomorrow() {
  return _today().add(const Duration(days: 1));
}
