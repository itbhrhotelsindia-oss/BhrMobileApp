import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HotelAmenitiesSection extends StatelessWidget {
  final String title;
  final List<String> amenities;

  const HotelAmenitiesSection({
    super.key,
    required this.title,
    required this.amenities,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hospitality That Goes Beyond Comfort",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: amenities.length,
              itemBuilder: (_, i) {
                final item = amenities[i];

                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: SizedBox(
                    width: 200,
                    child: _AmenityCard(item),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
class _AmenityCard extends StatelessWidget {
  final String title;

  const _AmenityCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            AppColors.darkGold1.withOpacity(0.18),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.darkGold2.withOpacity(0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// ICON
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkGold1.withOpacity(0.2),
            ),
            child: Text(
              _icon(title),
              style: const TextStyle(fontSize: 28),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            _description(title),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ ICON MAPPER
  String _icon(String s) {
    switch (s) {
      case "Swimming Pool":
        return "🏊‍♂️";
      case "Multi-Cuisine Restaurant":
        return "🍽️";
      case "Coworking Space":
        return "💻";
      case "Homy & Cozy Place":
        return "🏡";
      case "Conference Hall":
        return "🏢";
      case "Brewery":
        return "🍺";
      case "Coffee":
        return "☕";
      case "Kid-Zone":
        return "🧒";
      case "Souvenir shop":
        return "🛍️";
      case "Rain Dance":
        return "🌧️";
      case "Serenity Spa & Yoga":
        return "🧘‍♀️";
      case "Activities":
        return "🎯";
      case "Parking":
        return "🅿️";
      case "Free Wifi":
        return "📶";
      default:
        return "✨";
    }
  }

  // ✅ DESCRIPTION MAPPER
  String _description(String s) {
    switch (s) {
      case "Swimming Pool":
        return "Relax and unwind in our crystal-clear swimming pool.";
      case "Multi-Cuisine Restaurant":
        return "Enjoy delicious local and international cuisines.";
      case "Coworking Space":
        return "Comfortable workspaces for productivity.";
      case "Homy & Cozy Place":
        return "Feel at home with warm hospitality.";
      case "Conference Hall":
        return "Modern venue for meetings & events.";
      case "Brewery":
        return "Freshly crafted beverages.";
      case "Coffee":
        return "Premium freshly brewed coffee.";
      case "Kid-Zone":
        return "Safe and fun play area for kids.";
      case "Souvenir shop":
        return "Memorable keepsakes from your stay.";
      case "Rain Dance":
        return "Music, fun and refreshing rain dance.";
      case "Serenity Spa & Yoga":
        return "Relax your body and mind.";
      case "Activities":
        return "Indoor and outdoor entertainment.";
      case "Parking":
        return "Secure parking facility.";
      case "Free Wifi":
        return "High-speed internet access.";
      default:
        return "";
    }
  }
}


