class FooterWidget extends StatelessWidget {
  final ContactSection contact;

  const FooterWidget({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8EBDC),
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/logo.png",
            height: 70,
          ),

          const SizedBox(height: 20),

          Text(
            contact.companyName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(contact.corporateAddress),
          Text(contact.email),
          Text(contact.reservationPhone),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _social(Icons.facebook),
              _social(Icons.camera_alt),
              _social(Icons.play_circle),
              _social(Icons.close),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            "© BHR Hotels India",
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget _social(IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Icon(icon, size: 30),
    );
  }
}
