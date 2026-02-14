import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/city_model.dart';
import '../model/hotel_model.dart';
import '../../hotel_detail/view/hotel_detail_page.dart';
import '../../../core/theme/app_colors.dart';
import '../../booking/view/booking_search_page.dart';

class CityHotelsModal {
  static void open(BuildContext context, CityModel city) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (_) {
        return _CityHotelsContent(city: city);
      },
    );
  }
}

class _CityHotelsContent extends StatelessWidget {
  final CityModel city;

  const _CityHotelsContent({required this.city});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// drag indicator
            Container(
              width: 50,
              height: 5,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            /// city title
            Text(
              city.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// hotel list
            Flexible(
              child: ListView.builder(
                itemCount: city.hotels.length,
                itemBuilder: (_, i) {
                  final hotel = city.hotels[i];
                  return _HotelCard(hotel: hotel);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _HotelCard extends StatelessWidget {
  final HotelModel hotel;

  const _HotelCard({required this.hotel});

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => BookingSearchPage()),
                            );
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
