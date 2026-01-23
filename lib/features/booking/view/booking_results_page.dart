import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingResultsPage extends StatelessWidget {
  final String redirectUrl;

  const BookingResultsPage({
    super.key,
    required this.redirectUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Redirecting")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            launchUrl(
              Uri.parse(redirectUrl),
              mode: LaunchMode.externalApplication,
            );
          },
          child: const Text("Proceed to Payment"),
        ),
      ),
    );
  }
}
