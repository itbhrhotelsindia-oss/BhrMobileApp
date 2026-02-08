import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';
import '../view/booking_confirmation_page.dart';

class BookingAvailability extends StatefulWidget {
  final Map<String, dynamic> availability;
  final Map<String, dynamic> search;

  const BookingAvailability({
    super.key,
    required this.availability,
    required this.search,
  });

  @override
  State<BookingAvailability> createState() => _BookingAvailabilityState();
}

class _BookingAvailabilityState extends State<BookingAvailability> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String errorMessage = "";

  bool _validateForm() {
    if (_nameController.text.trim().isEmpty) {
      setState(() => errorMessage = "Guest name is required");
      return false;
    }

    if (!RegExp(r'^\S+@\S+\.\S+$')
        .hasMatch(_emailController.text.trim())) {
      setState(() => errorMessage = "Enter a valid email");
      return false;
    }

    if (!RegExp(r'^[0-9]{10}$')
        .hasMatch(_phoneController.text.trim())) {
      setState(() => errorMessage = "Phone must be 10 digits");
      return false;
    }

    setState(() => errorMessage = "");
    return true;
  }

  void _submitBooking() {
    if (!_validateForm()) return;

    final payload = {
      "hotelId": widget.availability["hotelId"],
      "roomTypeId": widget.availability["roomTypeId"],
      "checkIn": widget.search["checkIn"],
      "checkOut": widget.search["checkOut"],
      "rooms": widget.availability["roomsRequested"],
      "guestName": _nameController.text.trim(),
      "guestEmail": _emailController.text.trim(),
      "guestPhone": _phoneController.text.trim(),
    };

    context.read<BookingBloc>().add(SubmitBooking(payload));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state.confirmedBooking != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookingConfirmationPage(
                booking: state.confirmedBooking!,
                bookingDetail: widget.search,
              ),
            ),
          );
        }
      },
      child: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Available Rooms",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGold1,
                  ),
                ),

                const SizedBox(height: 14),

                _row("Hotel", widget.search["hotel"]),
                _row(
                  "Dates",
                  "${widget.search["checkIn"]} → ${widget.search["checkOut"]}",
                ),
                _row(
                  "Rooms",
                  "${widget.availability["roomsRequested"]}",
                ),

                const SizedBox(height: 20),

                const Text(
                  "Guest Details",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                _inputField(
                  label: "Guest Name",
                  controller: _nameController,
                ),

                const SizedBox(height: 12),

                _inputField(
                  label: "Email Address",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 12),

                _inputField(
                  label: "Phone Number",
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                ),

                const SizedBox(height: 12),

                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkGold1,
                      padding:
                      const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed:
                    state.submittingBooking ? null : _submitBooking,
                    child: state.submittingBooking
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "CONTINUE BOOKING",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Helpers

Widget _row(String label, dynamic value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        Text(value?.toString() ?? "-"),
      ],
    ),
  );
}

Widget _inputField({
  required String label,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  int? maxLength,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    maxLength: maxLength,
    inputFormatters: maxLength != null
        ? [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(maxLength),
    ]
        : null,
    decoration: InputDecoration(
      labelText: label,
      counterText: "",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
