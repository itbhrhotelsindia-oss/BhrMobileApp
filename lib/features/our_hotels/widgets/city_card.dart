import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/city_model.dart';
import '../view/city_hotels_page.dart';
import 'city_hotels_modal.dart';




class CityCard extends StatelessWidget {
  final CityModel city;

  const CityCard({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CityHotelsPage(city: city),
            ),
          );
        },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: city.cityImageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(12),
              color: Colors.black45,
              child: Text(
                city.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
