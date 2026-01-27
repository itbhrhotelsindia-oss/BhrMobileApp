import 'package:flutter/material.dart';
import '../../../core/api_client.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/our_hotels/model/city_model.dart';
import '../../../features/our_hotels/model/hotel_model.dart';
import '../../../core/theme/app_colors.dart';

class WeddingEnquiryForm extends StatefulWidget {
  const WeddingEnquiryForm({super.key});

  @override
  State<WeddingEnquiryForm> createState() => _WeddingEnquiryFormState();
}

class _WeddingEnquiryFormState extends State<WeddingEnquiryForm> {
  final _formKey = GlobalKey<FormState>();

  final api = ApiClient("https://hotel-backend-nq72.onrender.com");

  List<CityModel> cities = [];
  List<HotelModel> hotels = [];

  bool loadingCities = true;
  bool submitting = false;

  String responseMsg = "";

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final commentsCtrl = TextEditingController();

  String countryCode = "+91";
  String selectedCity = "";
  String selectedHotel = "";

  @override
  void initState() {
    super.initState();
    loadCities();
  }

  Future<void> loadCities() async {
    try {
      final res = await api.get("/api/cities/");
      cities =
          (res as List).map((e) => CityModel.fromJson(e)).toList();
    } catch (_) {}
    setState(() => loadingCities = false);
  }

  void onCityChanged(String? value) {
    if (value == null) return;

    final city = cities.firstWhere((c) => c.name == value);

    setState(() {
      selectedCity = value;
      hotels = city.hotels;
      selectedHotel = "";
    });
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      hintText: label,
      hintStyle: const TextStyle(color: Colors.black),
      labelStyle: const TextStyle(color: Colors.black54),
      prefixIcon: Icon(icon, color: Colors.grey.shade600),
      filled: true,
      fillColor: AppColors.gray,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      submitting = true;
      responseMsg = "";
    });

    try {
      final payload = {
        "name": nameCtrl.text,
        "email": emailCtrl.text,
        "countryCode": countryCode,
        "phone": phoneCtrl.text,
        "city": selectedCity,
        "queryFor": selectedHotel,
        "comments": commentsCtrl.text,
      };

      await api.post("/api/weddings/enquiry", payload);

      setState(() {
        responseMsg =
        "Thank you! Our wedding team will contact you shortly.";
        nameCtrl.clear();
        emailCtrl.clear();
        phoneCtrl.clear();
        commentsCtrl.clear();
        selectedCity = "";
        selectedHotel = "";
        hotels = [];
      });
    } catch (_) {
      responseMsg = "Something went wrong. Please try again.";
    }

    setState(() => submitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        shadowColor: Colors.black12,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                const Text(
                  "Wedding Enquiry",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGold1,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Begin your journey to a perfect celebration with us.",
                  style: TextStyle(
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

                _field("Full Name *", Icons.person_outline,
                    controller: nameCtrl,
                    validator: (v) =>
                    v!.isEmpty ? "Required" : null),

                _field("Email Address", Icons.email_outlined,
                    controller: emailCtrl,
                    keyboard: TextInputType.emailAddress),

                /// PHONE
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 90,
                //       child: TextFormField(
                //         initialValue: countryCode,
                //         decoration:
                //         _decoration("Code", Icons.phone_android),
                //         enabled: false,
                //       ),
                //     ),
                //     const SizedBox(width: 12),
                //     Expanded(
                //       child: ,
                //     ),
                //   ],
                // ),
                _field(
                  "Phone Number *",
                  Icons.phone_outlined,
                  controller: phoneCtrl,
                  keyboard: TextInputType.phone,
                  max: 10,
                  validator: (v) => v!.length != 10
                      ? "Enter valid 10 digit number"
                      : null,
                ),

                const SizedBox(height: 18),

                DropdownButtonFormField<String>(
                  value:
                  selectedCity.isEmpty ? null : selectedCity,
                  decoration:
                  _decoration("Select City *", Icons.location_city),
                  items: cities
                      .map(
                        (c) => DropdownMenuItem(
                      value: c.name,
                      child: Text(c.name),
                    ),
                  )
                      .toList(),
                  onChanged: onCityChanged,
                  validator: (v) =>
                  v == null ? "Required" : null,
                ),

                const SizedBox(height: 18),

                DropdownButtonFormField<String>(
                  value: selectedHotel.isEmpty
                      ? null
                      : selectedHotel,
                  decoration: _decoration(
                      "Select Hotel *", Icons.hotel_outlined),
                  hint: Text(hotels.isEmpty
                      ? "Select city first"
                      : "Choose hotel"),
                  items: hotels
                      .map(
                        (h) => DropdownMenuItem(
                      value: h.name,
                      child: Text(h.name),
                    ),
                  )
                      .toList(),
                  onChanged: hotels.isEmpty
                      ? null
                      : (v) =>
                      setState(() => selectedHotel = v!),
                  validator: (v) =>
                  v == null ? "Required" : null,
                ),

                const SizedBox(height: 18),

                _field(
                  "Additional Comments",
                  Icons.message_outlined,
                  controller: commentsCtrl,
                  lines: 4,
                ),

                const SizedBox(height: 36),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkGold1,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: submitting ? null : submit,
                    child: submitting
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "SUBMIT ENQUIRY",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.2,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                if (responseMsg.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      responseMsg,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: responseMsg.contains("Thank")
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
      String label,
      IconData icon, {
        required TextEditingController controller,
        int lines = 1,
        int? max,
        TextInputType keyboard = TextInputType.text,
        String? Function(String?)? validator,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        maxLines: lines,
        maxLength: max,
        keyboardType: keyboard,
        validator: validator,
        decoration: _decoration(label, icon),
      ),
    );
  }
}
