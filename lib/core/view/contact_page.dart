import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.65),

      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.92,
          constraints: const BoxConstraints(maxWidth: 600),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Stack(
            children: [
              /// ================= CONTENT =================
              Padding(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _Header(),
                      SizedBox(height: 30),

                      _Section(
                        title: "Reservations & Support",
                        items: [
                          _ContactItem(
                            icon: FontAwesomeIcons.phone,
                            text: "+91 9211283334",
                          ),
                          _ContactItem(
                            icon: FontAwesomeIcons.clock,
                            text: "Support Hours: 24×7",
                          ),
                        ],
                      ),

                      _Section(
                        title: "Online Support",
                        items: [
                          _ContactItem(
                            icon: FontAwesomeIcons.envelope,
                            text: "info@bhrhotelsindia.com",
                          ),
                          _ContactItem(
                            icon: FontAwesomeIcons.globe,
                            text: "www.bhrhotelsindia.com",
                          ),
                          _ContactItem(
                            icon: FontAwesomeIcons.whatsapp,
                            text: "Chat on WhatsApp",
                          ),
                        ],
                      ),

                      _Section(
                        title: "Corporate Office",
                        items: [
                          _ContactItem(
                            icon: FontAwesomeIcons.locationDot,
                            text:
                            "B-128, C-49, First Floor, Sector-2,\n"
                                "Noida, Gautam Buddha Nagar – 201301, India",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// ================= CLOSE BUTTON =================
              Positioned(
                top: 18,
                right: 18,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 18,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 26,
                      color: Color(0xFF7B4B00),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Contact Us",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7B4B00),
          ),
        ),
        SizedBox(height: 6),
        Text(
          "BHR Hotels India LLP\nDelivering trusted hospitality since 2010",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<_ContactItem> items;

  const _Section({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFFB7832F),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          ...items,
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(
            icon,
            size: 16,
            color: const Color(0xFF7B4B00),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14.5,
                color: Color(0xFF333333),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

