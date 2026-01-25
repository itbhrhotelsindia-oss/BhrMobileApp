import 'dart:async';
import 'package:flutter/material.dart';

class EventSliderWidget extends StatefulWidget {
  final List<String> images;
  final bool autoPlay;
  final int interval;

  const EventSliderWidget({
    super.key,
    required this.images,
    required this.autoPlay,
    required this.interval,
  });

  @override
  State<EventSliderWidget> createState() => _EventSliderWidgetState();
}

class _EventSliderWidgetState extends State<EventSliderWidget> {
  final PageController controller = PageController();
  Timer? timer;
  int index = 0;

  @override
  void initState() {
    super.initState();

    if (widget.autoPlay) {
      timer = Timer.periodic(
        Duration(milliseconds: widget.interval),
            (_) {
          index++;
          controller.animateToPage(
            index % widget.images.length,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: PageView.builder(
        controller: controller,
        itemCount: widget.images.length,
        itemBuilder: (_, i) {
          return ClipRRect(
            child: Image.network(
              widget.images[i],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
