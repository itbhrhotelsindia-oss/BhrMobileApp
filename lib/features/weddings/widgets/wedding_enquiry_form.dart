import 'package:flutter/material.dart';
import '../../../core/api_client.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/our_hotels/model/city_model.dart';
import '../../../features/our_hotels/model/hotel_model.dart';

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
      cities = (res as List)
          .map((e) => CityModel.fromJson(e))
          .toList();
    } catch (_) {}
    setState(() => loadingCities = false);
  }

  void onCityChanged(String? value) {
    if (value == null) return;

    final city = cities.firstWhere(
          (c) => c.name == value,
    );

    setState(() {
      selectedCity = value;
      hotels = city.hotels;
      selectedHotel = "";
    });
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
    } catch (e) {
      responseMsg = "Something went wrong. Please try again.";
    }

    setState(() => submitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              "ENQUIRE NOW",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGold1,
              ),
            ),

            const SizedBox(height: 30),

            _input("Name*", nameCtrl,
                validator: (v) =>
                v!.isEmpty ? "Required" : null),

            _input("Email", emailCtrl,
                keyboard: TextInputType.emailAddress),

            /// PHONE
            Row(
              children: [
                SizedBox(
                  width: 90,
                  child: DropdownButtonFormField(
                    value: countryCode,
                    items: const [
                      DropdownMenuItem(
                          value: "+91", child: Text("🇮🇳 +91"))
                    ],
                    onChanged: (v) =>
                        setState(() => countryCode = v!),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _input(
                    "Phone*",
                    phoneCtrl,
                    keyboard: TextInputType.phone,
                    max: 10,
                    validator: (v) =>
                    v!.length != 10
                        ? "Enter 10 digit number"
                        : null,
                  ),
                )
              ],
            ),

            const SizedBox(height: 14),

            /// CITY
            DropdownButtonFormField<String>(
              value:
              selectedCity.isEmpty ? null : selectedCity,
              hint: const Text("Select your location"),
              items: cities
                  .map((c) => DropdownMenuItem(
                value: c.name,
                child: Text(c.name),
              ))
                  .toList(),
              onChanged: onCityChanged,
              validator: (v) =>
              v == null ? "Required" : null,
            ),

            const SizedBox(height: 14),

            /// HOTEL
            DropdownButtonFormField<String>(
              value:
              selectedHotel.isEmpty ? null : selectedHotel,
              hint: Text(
                hotels.isEmpty
                    ? "Select location first"
                    : "Select hotel",
              ),
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

            const SizedBox(height: 14),

            _input(
              "Comments",
              commentsCtrl,
              lines: 4,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGold1,
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: submitting ? null : submit,
                child: submitting
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text(
                  "SUBMIT",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            if (responseMsg.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                responseMsg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _input(
      String label,
      TextEditingController ctrl, {
        int lines = 1,
        int? max,
        TextInputType keyboard = TextInputType.text,
        String? Function(String?)? validator,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: ctrl,
        maxLines: lines,
        maxLength: max,
        keyboardType: keyboard,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
