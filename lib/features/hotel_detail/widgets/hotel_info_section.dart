import 'package:flutter/material.dart';
import '../model/hotel_detail_model.dart';

class HotelInfoSection extends StatelessWidget {
  final HotelDetailModel hotel;

  const HotelInfoSection({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hotel.basicInfo.name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            hotel.hotelSlider.title,
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 16),

          Text(
            hotel.hotelSlider.subtitle,
            style: const TextStyle(fontSize: 16, height: 1.6),
          ),
        ],
      ),
    );
  }
}
