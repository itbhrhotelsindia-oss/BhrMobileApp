import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BookingAvailability extends StatelessWidget {
  final Map<String, dynamic> availability;
  final Map<String, dynamic> search;

  const BookingAvailability({
    super.key,
    required this.availability,
    required this.search,
  });

  @override
  Widget build(BuildContext context) {
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
          /// TITLE
          const Text(
            "Rooms Available",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGold1,
            ),
          ),

          const SizedBox(height: 14),

          _row("Hotel", search["hotel"]),
          _row("Room Type", search["roomTypeName"]),
          _row("Check-in", search["checkIn"]),
          _row("Check-out", search["checkOut"]),
          _row("Guests",
              "${search["adults"]} Adults, ${search["children"]} Children"),
          _row("Rooms", "${search["roomsRequested"]}"),

          const Divider(height: 30),

          _row(
            "Price / Night",
            "₹${search["pricePerNight"]}",
            bold: true,
          ),

          const SizedBox(height: 20),

          /// ACTION BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGold1,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                // 🔥 Next step: payment / confirm booking
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Proceeding to booking…"),
                  ),
                );
              },
              child: const Text(
                "CONFIRM BOOKING",
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
    );
  }
  }

  Widget _row(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
