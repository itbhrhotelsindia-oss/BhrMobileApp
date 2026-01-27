import 'package:flutter/material.dart';
import '../view/legal_page.dart';
class RefundPolicyPage extends StatelessWidget {
  const RefundPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalPage(
      from: "refundPolicy",
      apiPath: "/api/legal/refund-and-cancellation-policy",
    );
  }
}
