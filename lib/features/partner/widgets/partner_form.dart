import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/partner_bloc.dart';
import '../bloc/partner_event.dart';
import '../model/city_model.dart';
import '../model/partner_form_model.dart';

class PartnerForm extends StatefulWidget {
  final List<CityModel> cities;

  const PartnerForm({super.key, required this.cities});

  @override
  State<PartnerForm> createState() => _PartnerFormState();
}

class _PartnerFormState extends State<PartnerForm> {
  final formKey = GlobalKey<FormState>();
  final form = PartnerFormModel();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _input("Company Name*", (v) => form.companyName = v!),
            _input("Website", (v) => form.website = v ?? ""),
            _input("Full Name*", (v) => form.fullName = v!),
            _input("Email*", (v) => form.email = v!),
            _input("Contact Number*", (v) => form.contactNumber = v!),

            DropdownButtonFormField(
              hint: const Text("Select Partnership Type"),
              items: const [
                "Hotel Franchise",
                "Management Contract",
                "Investment Partnership",
                "Corporate Collaboration",
                "Vendor / Supplier Partnership",
                "Register Your Hotel"
              ]
                  .map((e) =>
                  DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) =>
              form.partnershipType = v.toString(),
              validator: (v) =>
              v == null ? "Required" : null,
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField(
              hint: const Text("Select Location"),
              items: widget.cities
                  .map(
                    (c) => DropdownMenuItem(
                  value: c.id,
                  child: Text(c.name),
                ),
              )
                  .toList(),
              onChanged: (v) => form.location = v.toString(),
              validator: (v) =>
              v == null ? "Required" : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              maxLines: 4,
              decoration:
              const InputDecoration(labelText: "Message"),
              onChanged: (v) => form.message = v,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  context
                      .read<PartnerBloc>()
                      .add(SubmitPartnerForm(form));
                },
                child: const Text("Submit Application"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String label, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        decoration: InputDecoration(labelText: label),
        validator: (v) =>
        (v == null || v.isEmpty) ? "Required" : null,
        onChanged: onChanged,
      ),
    );
  }
}
