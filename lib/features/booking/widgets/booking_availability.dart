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
  late String selectedTab;
  late Map<String, dynamic> selectedPricing;

  String errorMessage = "";

  @override
  void initState() {
    super.initState();

    /// Same as React useEffect
    selectedPricing = widget.availability["pricingOptions"][0];
    selectedTab = selectedPricing["payMode"];
  }

  bool _validate() {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty) {
      setState(() => errorMessage = "Please fill all guest details");
      return false;
    }

    if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(_emailController.text.trim())) {
      setState(() => errorMessage = "Enter valid email");
      return false;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(_phoneController.text.trim())) {
      setState(() => errorMessage = "Phone must be 10 digits");
      return false;
    }

    setState(() => errorMessage = "");
    return true;
  }

  void _handleContinue() {
    if (!_validate()) return;

    final payload = {
      "hotelId": widget.availability["hotelId"],
      "roomTypeId": widget.availability["roomTypeId"],
      "checkIn": widget.search["checkIn"],
      "checkOut": widget.search["checkOut"],
      "rooms": widget.availability["roomsRequested"],

      /// 🔥 pricing part
      "pricingType": selectedPricing["type"],
      "payMode": selectedPricing["payMode"],
      "pricePerNight": selectedPricing["pricePerNight"],
      "totalAmount": selectedPricing["totalAmount"],

      /// guest
      "guestName": _nameController.text.trim(),
      "guestEmail": _emailController.text.trim(),
      "guestPhone": _phoneController.text.trim(),
    };

    context.read<BookingBloc>().add(SubmitBooking(payload));
  }

  @override
  Widget build(BuildContext context) {
    final allOptions = widget.availability["pricingOptions"] as List;

    final payNowOptions = allOptions
        .where((p) => p["payMode"] == "PAY_NOW")
        .toList();

    final payAtHotelOptions = allOptions
        .where((p) => p["payMode"] == "PAY_AT_HOTEL")
        .toList();

    final visibleOptions = selectedTab == "PAY_NOW"
        ? payNowOptions
        : payAtHotelOptions;

    final pricingOptions = widget.availability["pricingOptions"] as List;

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
                  "Choose Your Price",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGold1,
                  ),
                ),

                const SizedBox(height: 16),

                /// SUMMARY
                _row("Hotel", widget.search["hotel"]),
                _row(
                  "Dates",
                  "${widget.search["checkIn"]} → ${widget.search["checkOut"]}",
                ),
                _row(
                  "Rooms",
                  "${widget.availability["roomsRequested"]} • Nights: ${widget.availability["nights"]}",
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(child: _pricingTab("PAY_NOW")),
                    const SizedBox(width: 12),
                    Expanded(child: _pricingTab("PAY_AT_HOTEL")),
                  ],
                ),

                const SizedBox(height: 20),
                Column(
                  children: visibleOptions.map((p) {
                    final isSelected =
                        selectedPricing["type"] == p["type"] &&
                        selectedPricing["payMode"] == p["payMode"];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPricing = p;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.darkGold1.withOpacity(0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.darkGold1
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: AppColors.darkGold1.withOpacity(0.2),
                                blurRadius: 10,
                              ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p["type"].toString().replaceAll("_", " "),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  p["payMode"].toString().replaceAll("_", " "),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.green
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "₹${p["pricePerNight"]} / night",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "₹${p["totalAmount"]}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.darkGold1,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

                /// TOTAL
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "₹${selectedPricing["totalAmount"]}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Guest Details",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 12),

                _inputField(label: "Guest Name", controller: _nameController),

                const SizedBox(height: 12),

                _inputField(
                  label: "Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 12),

                _inputField(
                  label: "Phone",
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                ),

                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 24),

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
                    onPressed: state.submittingBooking ? null : _handleContinue,
                    child: state.submittingBooking
                        ? const CircularProgressIndicator(color: Colors.white)
                        :  const Text(
                      "Continue Booking",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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

  Widget _pricingTab(String type) {
    final isActive = selectedTab == type;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = type;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.darkGold1 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              type.replaceAll("_", " "),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

