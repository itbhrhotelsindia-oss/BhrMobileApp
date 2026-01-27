import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WhyBookDirectPage extends StatelessWidget {
  const WhyBookDirectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.65),

      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.94,
          constraints: const BoxConstraints(maxWidth: 900),
          height: MediaQuery.of(context).size.height * 0.9,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Stack(
            children: [
              /// ================= CONTENT =================
              Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Header(),
                      const SizedBox(height: 30),
                      const _BenefitsList(),
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
          "Why Book Direct",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7B4B00),
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Book directly with BHR Hotels India LLP and enjoy exclusive benefits "
              "designed for comfort, savings, and peace of mind.",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
class _BenefitsList extends StatelessWidget {
  const _BenefitsList();

  @override
  Widget build(BuildContext context) {
    final items = [
      _WhyItem(
        icon: FontAwesomeIcons.indianRupeeSign,
        title: "Best Price Guaranteed",
        desc:
        "Get the lowest available rates when you book directly with us, "
            "with no hidden charges.",
      ),
      _WhyItem(
        icon: FontAwesomeIcons.tags,
        title: "Exclusive Offers",
        desc:
        "Enjoy special deals, seasonal discounts, and value-added benefits "
            "available only on our website.",
      ),
      _WhyItem(
        icon: FontAwesomeIcons.headset,
        title: "Personalized Assistance",
        desc:
        "Speak directly with our reservations team for tailored support "
            "and customized stay experiences.",
      ),
      _WhyItem(
        icon: FontAwesomeIcons.clock,
        title: "Flexible Policies",
        desc:
        "Benefit from more flexible cancellation and modification options "
            "compared to third-party platforms.",
      ),
      _WhyItem(
        icon: FontAwesomeIcons.shieldHalved,
        title: "Secure & Trusted Booking",
        desc:
        "Your information is protected with secure payment gateways and "
            "trusted booking processes.",
      ),
      _WhyItem(
        icon: FontAwesomeIcons.star,
        title: "Priority Guest Benefits",
        desc:
        "Direct bookers receive priority services, special requests "
            "handling, and exclusive privileges.",
      ),
    ];

    return Column(
      children: items
          .map(
            (item) => _WhyListCard(item: item),
      )
          .toList(),
    );
  }
}

class _WhyListCard extends StatelessWidget {
  final _WhyItem item;

  const _WhyListCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F6F3),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFB7832F).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: FaIcon(
                item.icon,
                size: 22,
                color: const Color(0xFFB7832F),
              ),
            ),
          ),

          const SizedBox(width: 18),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.desc,
                  style: const TextStyle(
                    fontSize: 14.5,
                    height: 1.6,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WhyItem {
  final IconData icon;
  final String title;
  final String desc;

  _WhyItem({
    required this.icon,
    required this.title,
    required this.desc,
  });
}

