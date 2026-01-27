import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/events_bloc.dart';
import '../bloc/events_event.dart';
import '../bloc/events_state.dart';
import '../model/event_enquiry_model.dart';
import '../../our_hotels/model/city_model.dart';
import '../../../core/theme/app_colors.dart';

class EventEnquiryForm extends StatefulWidget {
  final String selectedCategory;
  final List<String> eventTypes;
  final List<CityModel> cities;

  const EventEnquiryForm({
    super.key,
    required this.selectedCategory,
    required this.eventTypes,
    required this.cities,
  });

  @override
  State<EventEnquiryForm> createState() => _EventEnquiryFormState();
}

class _EventEnquiryFormState extends State<EventEnquiryForm> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final queryCtrl = TextEditingController();
  String responseMsg = "";
  bool isSuccess = false;

  String countryCode = "+91";
  String eventType = "";
  String location = "";

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      hintText: label,
      hintStyle: const TextStyle(color: Colors.black),

      prefixIcon: Icon(icon, color: Colors.black),

      filled: true,
      fillColor: AppColors.gray,

      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.background, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventsBloc, EventsState>(
        listener: (context, state) {
          if (state is EventsSuccess) {
            setState(() {
              responseMsg = state.message;
              isSuccess = true;

              nameCtrl.clear();
              emailCtrl.clear();
              phoneCtrl.clear();
              queryCtrl.clear();

              eventType = "";
              location = "";
            });
          }

          if (state is EventsError) {
            setState(() {
              responseMsg = state.message;
              isSuccess = false;
            });
          }
        },
        child: BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            final submitting = state is EventsSubmitting;

        return Container(
          child: Center(
            child: Card(
              elevation: 6,
              shadowColor: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// HEADER
                      const Text(
                        "Event Enquiry",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightBlue3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Fill in the details and our events team will contact you.",
                        style: TextStyle(color: Colors.black54, height: 1.4),
                      ),

                      const SizedBox(height: 32),

                      /// NAME
                      TextFormField(
                        controller: nameCtrl,
                        decoration: _decoration(
                          "Full Name *",
                          Icons.person_outline,
                        ),
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),

                      const SizedBox(height: 18),

                      /// EMAIL
                      TextFormField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _decoration(
                          "Email Address",
                          Icons.email_outlined,
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// PHONE
                      TextFormField(
                        controller: phoneCtrl,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: _decoration(
                          "Mobile Number *",
                          Icons.phone_outlined,
                        ),
                        validator: (v) =>
                            v!.length != 10 ? "Enter 10 digit number" : null,
                      ),

                      const SizedBox(height: 18),

                      /// EVENT TYPE
                      DropdownButtonFormField<String>(
                        value: eventType.isEmpty ? null : eventType,
                        decoration: _decoration(
                          "Type of Event *",
                          Icons.celebration_outlined,
                        ),
                        items: widget.eventTypes
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => eventType = v!),
                        validator: (v) => v == null ? "Required" : null,
                      ),

                      const SizedBox(height: 18),

                      /// LOCATION
                      DropdownButtonFormField<String>(
                        value: location.isEmpty ? null : location,
                        decoration: _decoration(
                          "Preferred Location *",
                          Icons.location_on_outlined,
                        ),
                        items: widget.cities
                            .map(
                              (c) => DropdownMenuItem(
                                value: c.name,
                                child: Text(
                                  c.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => location = v!),
                        validator: (v) => v == null ? "Required" : null,
                      ),

                      const SizedBox(height: 18),

                      /// MESSAGE
                      TextFormField(
                        controller: queryCtrl,
                        maxLines: 4,
                        decoration: _decoration(
                          "Additional Message",
                          Icons.message_outlined,
                        ),
                      ),

                      const SizedBox(height: 30),

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
                          onPressed: submitting ? null : _submit,
                          child: submitting
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "SUBMIT ENQUIRY",
                                  style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 1,
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
                              color:
                              isSuccess ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
        )
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final form = EventEnquiryModel(
      category: widget.selectedCategory,
      name: nameCtrl.text,
      email: emailCtrl.text,
      phone: phoneCtrl.text,
      eventType: eventType,
      location: location,
      query: queryCtrl.text,
    );

    context.read<EventsBloc>().add(SubmitEventEnquiry(form));
  }
}
