import 'package:flutter/material.dart';
import '../view/legal_page.dart';
class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalPage(
      from: "termsAndConditions",
      apiPath: "/api/legal/terms-and-conditions",
    );
  }
}
