import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/home_model.dart';

class EventsSection extends StatefulWidget {
  final EventsSectionModel section;

  const EventsSection({
    super.key,
    required this.section,
  });

  @override
  State<EventsSection> createState() => _EventsSectionState();
}

class _EventsSectionState extends State<EventsSection> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final events = widget.section.events;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Text(
            widget.section.title,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),

          SizedBox(
            height: 420,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.82),
              onPageChanged: (i) => setState(() => index = i),
              itemCount: events.length,
              itemBuilder: (_, i) {
                final e = events[i];

                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: CachedNetworkImage(
                          imageUrl: e.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          memCacheWidth: 900,
                          placeholder: (_, __) =>
                              Container(color: Colors.black12),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(18),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                e.title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                e.description,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
