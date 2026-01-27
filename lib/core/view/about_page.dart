import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.65),

      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          constraints: const BoxConstraints(maxWidth: 900),
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),

          child: Stack(
            children: [
              /// ================= CONTENT =================
              Padding(
                padding: const EdgeInsets.all(32),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _Header(),

                      SizedBox(height: 35),

                      _Section(
                        title: "Who We Are",
                        content:
                        "BHR Hotels India LLP is a growing hospitality brand dedicated to delivering refined experiences through thoughtfully curated hotels and resorts. Since our inception, we have focused on blending comfort, culture, and personalized service.",
                      ),

                      _Section(
                        title: "Our Journey",
                        content:
                        "Established in 2010, BHR Hotels India LLP has expanded its presence across leisure destinations, pilgrimage cities, and business hubs—offering guests a seamless blend of modern luxury and local charm.",
                      ),

                      _BulletSection(
                        title: "What Makes Us Different",
                        bullets: [
                          "Carefully selected hotels & resorts",
                          "Personalized guest-centric service",
                          "Ideal venues for weddings, events & retreats",
                          "Strong focus on comfort, safety & cleanliness",
                        ],
                      ),

                      _Section(
                        title: "Our Promise",
                        content:
                        "Whether you are planning a family getaway, destination wedding, corporate event, or a peaceful retreat, BHR Hotels India LLP promises thoughtful hospitality and experiences that stay with you long after checkout.",
                      ),

                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              /// ================= CLOSE BUTTON =================
              Positioned(
                top: 16,
                right: 16,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 12,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFF7B4B00),
                      size: 26,
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
      children: const [
        Text(
          "About BHR Hotels India LLP",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7B4B00),
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Crafting memorable stays with warmth, elegance, and authentic hospitality across India.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
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
  final String content;

  const _Section({
    required this.title,
    required this.content,
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
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9C6925),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF444444),
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletSection extends StatelessWidget {
  final String title;
  final List<String> bullets;

  const _BulletSection({
    required this.title,
    required this.bullets,
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
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9C6925),
            ),
          ),
          const SizedBox(height: 10),
          ...bullets.map(
                (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "✔ $e",
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF444444),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
