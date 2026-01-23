import 'package:flutter/material.dart';
import '../models/home_model.dart';
import '../../../core/theme/app_colors.dart';

class BrandBannerWidget extends StatelessWidget {
  final BrandBanner banner;

  const BrandBannerWidget({
    super.key,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainBlue,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Text(
            banner.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            banner.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: banner.contacts.map((c) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: OutlinedButton.icon(
                  icon: Icon(
                    c.type == "phone"
                        ? Icons.phone
                        : Icons.email,
                    color: Colors.white,
                  ),
                  label: Text(
                    c.displayValue,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white30),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
