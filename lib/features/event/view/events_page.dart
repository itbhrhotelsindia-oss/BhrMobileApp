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
import '../repository/events_repository.dart';
import 'package:bhrhotel/core/api_client.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String selected = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<EventsBloc>()
        ..add(LoadEventsPage()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Events"),
          centerTitle: true,
        ),
        body: BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            if (state is EventsLoading ||
                state is EventsInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is EventsError) {
              return Center(child: Text(state.message));
            }

            if (state is EventsLoaded) {
              final data = state.data;

              selected = selected.isEmpty
                  ? data.eventsSection.eventCategories.first.key
                  : selected;

              final selectedEvent = data.eventsSection.eventCategories
                  .firstWhere((e) => e.key == selected);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    /// SLIDER
                    EventSliderWidget(
                      images: data.eventSlider.images,
                      autoPlay: data.eventSlider.autoPlay,
                      interval: data.eventSlider.interval,
                    ),

                    const SizedBox(height: 20),

                    /// DESCRIPTION
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        data.eventsSection.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// CATEGORY GRID
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

                    /// FORM
                  EventEnquiryForm(
                    selectedCategory: selected,
                    eventTypes: data.eventsSection.eventCategories
                      .map((e) => e.title)
                      .toList(),
                    cities: state.cities,
                  ),

                    const SizedBox(height: 60),
                  ],
                ),
              );
            }


            return const SizedBox();
          },
        ),
      ),
    );
  }
}

