import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/home_model.dart';
import '../../../core/theme/app_colors.dart';

class BrandBannerWidget extends StatelessWidget {
  final BrandBanner banner;
  final ContactSection contact;

  const BrandBannerWidget({
    super.key,
    required this.banner,
    required this.contact,
  });

  /// Open URL Function
  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

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

          // const SizedBox(height: 16),

          // Text(
          //   banner.subtitle,
          //   textAlign: TextAlign.center,
          //   style: const TextStyle(
          //     color: Colors.white70,
          //     fontSize: 16,
          //   ),
          // ),
          const SizedBox(height: 10),

          /// Contact Buttons
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: banner.contacts.map((c) {
          //     return Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 10),
          //       child: OutlinedButton.icon(
          //         icon: Icon(
          //           c.type == "phone"
          //               ? Icons.phone
          //               : Icons.email,
          //           color: Colors.white,
          //         ),
          //         label: Text(
          //           c.displayValue,
          //           style: const TextStyle(color: Colors.white),
          //         ),
          //         onPressed: () {},
          //         style: OutlinedButton.styleFrom(
          //           side: const BorderSide(color: Colors.white30),
          //         ),
          //       ),
          //     );
          //   }).toList(),
          // ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: OutlinedButton.icon(
                  icon: Icon(Icons.phone, color: Colors.white),
                  label: Text(
                    "Reservations: ${contact.reservationPhone}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white30),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: OutlinedButton.icon(
                  icon: Icon(Icons.phone, color: Colors.white),
                  label: Text(
                    "Travel Partner / Wedding: ${contact.travelWeddingPhone}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white30),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: OutlinedButton.icon(
                  icon: Icon(Icons.phone, color: Colors.white),
                  label: Text(
                    "Corporate Tie-Ups: ${contact.corporateTieupPhone}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white30),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: OutlinedButton.icon(
                  icon: Icon(Icons.phone, color: Colors.white),
                  label: Text(
                    "Hotel Registration: ${contact.hotelRegistrationPhone}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white30),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          /// Social Media Title
          const Text(
            "Follow Us",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          /// Social Media Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                ),
                onPressed: () => openLink(contact.socialLinks.facebook ?? ""),
              ),

              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.white,
                ),
                onPressed: () => openLink(contact.socialLinks.instagram ?? ""),
              ),

              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Colors.white,
                ),
                onPressed: () => openLink(contact.socialLinks.twitterX ?? ""),
              ),

              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.linkedin,
                  color: Colors.white,
                ),
                onPressed: () => openLink(contact.socialLinks.linkedIn ?? ""),
              ),

              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.youtube,
                  color: Colors.white,
                ),
                onPressed: () => openLink(contact.socialLinks.youtube ?? ""),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
