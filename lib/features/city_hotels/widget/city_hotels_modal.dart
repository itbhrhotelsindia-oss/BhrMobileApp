import 'package:flutter/material.dart';
import '../model/hotel_model.dart';
import 'hotel_card.dart';

class CityHotelsModal {
  static void open(
      BuildContext context, {
        required String cityName,
        required List<HotelModel> hotels,
        required Function(HotelModel) onHotelTap,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.9,
          maxChildSize: 0.95,
          minChildSize: 0.6,
          builder: (_, controller) {
            return Column(
              children: [
                const SizedBox(height: 12),

                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  cityName,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: GridView.builder(
                    controller: controller,
                    padding: const EdgeInsets.all(16),
                    itemCount: hotels.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (_, i) {
                      return HotelCard(
                        hotel: hotels[i],
                        onTap: () {
                          Navigator.pop(context);
                          onHotelTap(hotels[i]);
                        },
                      );
                    },
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
