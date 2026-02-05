import 'package:flutter/material.dart';
import '../model/hotel_detail_model.dart';
import '../../booking/widgets/booking_modal.dart';
import '../../booking/view/booking_search_page.dart';

class BookNowBottomBar extends StatelessWidget {
  final HotelDetailModel hotel;

  const BookNowBottomBar({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              color: Colors.black12,
            )
          ],
        ),
        child: SafeArea(
          top: false,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingSearchPage(),
                ),
              );
              // BookingModal.open(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const StadiumBorder(),
            ),
            child: const Text(
              "BOOK NOW",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
