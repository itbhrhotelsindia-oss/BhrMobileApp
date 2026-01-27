import 'package:flutter/material.dart';

class CareersPage extends StatelessWidget {
  const CareersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.65),

      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.94,
          constraints: const BoxConstraints(maxWidth: 850),
          height: MediaQuery.of(context).size.height * 0.9,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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

                      SizedBox(height: 30),

                      _Section(
                        title: "Why Join BHR Hotels India LLP?",
                        content:
                        "At BHR Hotels India LLP, we believe our people are the heart of our success. We foster a collaborative work culture where passion, professionalism, and personal growth come together to create exceptional hospitality experiences.",
                      ),

                      _SectionWithList(
                        title: "What We Offer",
                        items: [
                          "Opportunities across hotels, resorts, and corporate offices",
                          "A supportive and inclusive work environment",
                          "Continuous learning and skill development",
                          "Growth-oriented career paths in hospitality",
                          "Exposure to diverse roles and destinations",
                        ],
                      ),

                      _Section(
                        title: "Who We’re Looking For",
                        content:
                        "We are always looking for passionate individuals who share our commitment to service excellence, teamwork, and guest satisfaction. Whether you are an experienced professional or just starting your journey, we welcome talent that is eager to learn and grow.",
                      ),

                      _ApplySection(),

                      SizedBox(height: 30),
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
          "Careers",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7B4B00),
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Build a meaningful career in hospitality with BHR Hotels India LLP",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
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
      padding: const EdgeInsets.only(bottom: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFB7832F),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14.5,
              height: 1.65,
              color: Color(0xFF444444),
            ),
          ),
        ],
      ),
    );
  }
}
class _SectionWithList extends StatelessWidget {
  final String title;
  final List<String> items;

  const _SectionWithList({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFB7832F),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Column(
              children: items
                  .map(
                    (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("•  "),
                      Expanded(
                        child: Text(
                          e,
                          style: const TextStyle(
                            fontSize: 14.5,
                            height: 1.6,
                            color: Color(0xFF444444),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
class _ApplySection extends StatelessWidget {
  const _ApplySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Apply With Us",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFB7832F),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "To explore career opportunities with BHR Hotels India LLP, please share your updated resume and details with us at:",
            style: TextStyle(
              fontSize: 14.5,
              height: 1.65,
              color: Color(0xFF444444),
            ),
          ),
          SizedBox(height: 10),
          SelectableText(
            "📧 info@bhrhotelsindia.com",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7B4B00),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Our HR team will get in touch with shortlisted candidates.",
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF777777),
            ),
          ),
        ],
      ),
    );
  }
}
