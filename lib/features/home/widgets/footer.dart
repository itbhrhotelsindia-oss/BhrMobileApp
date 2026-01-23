import 'package:flutter/material.dart';
import '../models/home_model.dart';

class FooterWidget extends StatelessWidget {
  final ContactSection contact;

  const FooterWidget({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8EBDC),
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            contact.companyName ?? "",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(contact.corporateAddress ?? ""),
          const SizedBox(height: 6),
          Text(contact.email ?? ""),
          const SizedBox(height: 6),
          Text(contact.reservationPhone ?? ""),
        ],
      ),
    );
  }
}
