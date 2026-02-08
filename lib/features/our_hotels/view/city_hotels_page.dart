import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/city_model.dart';
import '../model/hotel_model.dart';
import '../../hotel_detail/view/hotel_detail_page.dart';
import '../view/city_hotels_page.dart';
import '../../../core/theme/app_colors.dart';
import 'package:bhrhotel/app/app_shell.dart';

class CityHotelsPage extends StatelessWidget {
  final CityModel city;

  const CityHotelsPage({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.darkGold1,
            size: 20,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const AppShell(), // ✅ home page
              ),
                  (route) => false, // removes all previous routes
            );
          },
        ),
        title: Text(
          city.name,
          style: TextStyle(
            fontSize: 22,
            color: AppColors.darkGold1,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: city.hotels.length,
        itemBuilder: (_, i) {
          return HotelCard(hotel: city.hotels[i]);
        },
      ),
    );
  }
}


class HotelCard extends StatelessWidget {
  final HotelModel hotel;

  const HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// image
            CachedNetworkImage(
              imageUrl: hotel.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// hotel name
                  Text(
                    hotel.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                  const SizedBox(height: 10),

                  /// ⭐ SERVICES BADGES
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: hotel.services
                        .map((s) => _ServiceBadge(s))
                        .toList(),
                  ),

                  const SizedBox(height: 14),
                  // if (hotel.description != null)
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 6),
                  //     child: Text(
                  //       hotel.description!,
                  //       maxLines: 2,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: const TextStyle(
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //   ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      /// VISIT HOTEL
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HotelDetailPage(
                                  hotelId: hotel.hotelId,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkGold1,
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(
                            "VISIT HOTEL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// BOOK NOW
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // BookingModal.open(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightBlue2,
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(
                            "BOOK NOW",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _ServiceBadge extends StatelessWidget {
  final String service;

  const _ServiceBadge(this.service);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkGold1.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.darkGold2.withOpacity(0.4),
        ),
      ),
      child: Text(
        "${_icon()} $service",
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _icon() {
    switch (service) {
      case "MICE":
        return "🏨";
      case "Wedding":
        return "💍";
      case "Vacation":
        return "🌴";
      case "Safari":
        return "🦁";
      case "Nature Retreat":
        return "🌅";
      case "Pilgrimage":
        return "🛕";
      case "Honeymoon":
        return "❤️";
      default:
        return "✨";
    }
  }
}
