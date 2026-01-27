import 'package:flutter/material.dart';

class ManageBookingPage extends StatefulWidget {
  const ManageBookingPage({super.key});

  @override
  State<ManageBookingPage> createState() => _ManageBookingPageState();
}

class _ManageBookingPageState extends State<ManageBookingPage> {
  final _formKey = GlobalKey<FormState>();

  final bookingIdCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  String message = "";

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Color(0xFFC9C9C9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide:
        const BorderSide(color: Color(0xFFB7832F), width: 1.5),
      ),
    );
  }

  void submit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      message = "Fetching booking details...";
    });

    /// 🔗 API integration can be added here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.65),

      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.94,
          constraints: const BoxConstraints(maxWidth: 480),
          padding: const EdgeInsets.all(32),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Stack(
            children: [
              /// ================= CONTENT =================
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Manage Booking",
                      style: TextStyle(
                        fontSize: 28,
                        color: Color(0xFF7B4B00),
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Retrieve or manage your reservation using your booking details",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// BOOKING ID
                    const Text(
                      "Booking ID*",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: bookingIdCtrl,
                      decoration:
                      _decoration("Enter your Booking ID"),
                      validator: (v) =>
                      v == null || v.isEmpty ? "Required" : null,
                    ),

                    const SizedBox(height: 14),

                    /// EMAIL
                    const Text(
                      "Email Address*",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                      _decoration("Enter your Email"),
                      validator: (v) =>
                      v == null || v.isEmpty ? "Required" : null,
                    ),

                    const SizedBox(height: 22),

                    /// BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB7832F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: submit,
                        child: const Text(
                          "FIND BOOKING",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    if (message.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ],

                    const SizedBox(height: 22),

                    /// HELP
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF777777),
                        ),
                        children: [
                          TextSpan(text: "Need assistance? Contact our support team at "),
                          TextSpan(
                            text: "info@bhrhotelsindia.com",
                            style: TextStyle(
                              color: Color(0xFF7B4B00),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: " or call "),
                          TextSpan(
                            text: "+91 9211283334",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// ================= CLOSE =================
              Positioned(
                top: -8,
                right: -8,
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
