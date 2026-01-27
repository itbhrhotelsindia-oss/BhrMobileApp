import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/partner_bloc.dart';
import '../bloc/partner_event.dart';
import '../model/city_model.dart';
import '../model/partner_form_model.dart';
import '../../../core/theme/app_colors.dart';

class PartnerForm extends StatefulWidget {
  final List<CityModel> cities;

  const PartnerForm({super.key, required this.cities});

  @override
  State<PartnerForm> createState() => _PartnerFormState();
}

class _PartnerFormState extends State<PartnerForm> {
  final formKey = GlobalKey<FormState>();
  final form = PartnerFormModel();

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      hintText: label,
      hintStyle: const TextStyle(color: Colors.black),
      prefixIcon: Icon(icon, color: Colors.grey.shade600),
      filled: true,
      fillColor: AppColors.gray,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Card(
          elevation: 6,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // /// HEADER
                  // const Text(
                  //   "Partner With Us",
                  //   style: TextStyle(
                  //     fontSize: 26,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  const SizedBox(height: 6),
                  const Text(
                    "Share your details and our partnership team will contact you.",
                    style: TextStyle(
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// COMPANY
                  _input(
                    "Company Name *",
                    Icons.business,
                        (v) => form.companyName = v!,
                  ),

                  _input(
                    "Website",
                    Icons.language,
                        (v) => form.website = v ?? "",
                  ),

                  _input(
                    "Full Name *",
                    Icons.person_outline,
                        (v) => form.fullName = v!,
                  ),

                  _input(
                    "Email Address *",
                    Icons.email_outlined,
                        (v) => form.email = v!,
                    keyboard: TextInputType.emailAddress,
                  ),

                  _input(
                    "Contact Number *",
                    Icons.phone_outlined,
                        (v) => form.contactNumber = v!,
                    keyboard: TextInputType.phone,
                  ),

                  const SizedBox(height: 18),

                  /// PARTNERSHIP TYPE
                  DropdownButtonFormField(
                    decoration: _decoration(
                      "Partnership Type *",
                      Icons.handshake_outlined,
                    ),
                    items: const [
                      "Hotel Franchise",
                      "Management Contract",
                      "Investment Partnership",
                      "Corporate Collaboration",
                      "Vendor / Supplier Partnership",
                      "Register Your Hotel",
                    ]
                        .map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (v) =>
                    form.partnershipType = v.toString(),
                    validator: (v) =>
                    v == null ? "Required" : null,
                  ),

                  const SizedBox(height: 18),

                  /// LOCATION
                  DropdownButtonFormField(
                    decoration: _decoration(
                      "Preferred Location *",
                      Icons.location_on_outlined,
                    ),
                    items: widget.cities
                        .map(
                          (c) => DropdownMenuItem(
                        value: c.id,
                        child: Text(c.name),
                      ),
                    )
                        .toList(),
                    onChanged: (v) =>
                    form.location = v.toString(),
                    validator: (v) =>
                    v == null ? "Required" : null,
                  ),

                  const SizedBox(height: 18),

                  /// MESSAGE
                  TextFormField(
                    maxLines: 4,
                    decoration: _decoration(
                      "Additional Message",
                      Icons.message_outlined,
                    ),
                    onChanged: (v) => form.message = v,
                  ),

                  const SizedBox(height: 32),

                  /// SUBMIT BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkGold1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        context
                            .read<PartnerBloc>()
                            .add(SubmitPartnerForm(form));
                      },
                      child: const Text(
                        "SUBMIT APPLICATION",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(
      String label,
      IconData icon,
      Function(String?) onChanged, {
        TextInputType keyboard = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        keyboardType: keyboard,
        decoration: _decoration(label, icon),
        validator: (v) =>
        (v == null || v.isEmpty) ? "Required" : null,
        onChanged: onChanged,
      ),
    );
  }
}
