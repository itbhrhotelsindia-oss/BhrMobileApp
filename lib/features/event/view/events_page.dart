import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../event/widgets/event_category_card.dart';
import '../../event/widgets/event_category_grid.dart';
import '../../event/widgets/event_enquiry_form.dart';
import '../../event/widgets/event_section_title.dart';
import '../../event/widgets/event_slider_widget.dart';
import '../bloc/events_bloc.dart';
import '../bloc/events_event.dart';
import '../bloc/events_state.dart';
import '../model/events_page_model.dart';
import '../repository/events_repository.dart';
import 'package:bhrhotel/core/api_client.dart';
import '../../our_hotels/model/city_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../app/app_shell.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String selected = "";

  EventsPageModel? cachedPage;
  List<CityModel> cachedCities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.darkGold1,
            size: 20,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const AppShell(), // ✅ home page
              ),
                  (route) => false, // removes all previous routes
            );
          },
        ),
        title: const Text(
          "Events",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGold1,
          ),
        ),
        centerTitle: true,
      ),

      body: BlocBuilder<EventsBloc, EventsState>(
        builder: (context, state) {
          /// cache once
          if (state is EventsLoaded) {
            cachedPage = state.data;
            cachedCities = state.cities;
          }

          if (cachedPage == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = cachedPage!;

          selected = selected.isEmpty
              ? data.eventsSection.eventCategories.first.key
              : selected;

          return SingleChildScrollView(
            child: Column(
              children: [
                EventSliderWidget(
                  images: data.eventSlider.images,
                  autoPlay: data.eventSlider.autoPlay,
                  interval: data.eventSlider.interval,
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    data.eventsSection.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                ),

                const SizedBox(height: 30),

                EventCategoryGrid(
                  categories: data.eventsSection.eventCategories,
                  selectedKey: selected,
                  onSelected: (category) {
                    setState(() {
                      selected = category.key;
                    });
                  },
                ),

                const SizedBox(height: 40),

                EventEnquiryForm(
                  selectedCategory: selected,
                  eventTypes: data.eventsSection.eventCategories
                      .map((e) => e.title)
                      .toList(),
                  cities: cachedCities,
                ),

                const SizedBox(height: 60),
              ],
            ),
          );
        },
      ),
    );
  }
}

