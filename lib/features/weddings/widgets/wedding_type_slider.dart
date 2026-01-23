import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/type_of_wedding_model.dart';

class WeddingTypeSlider extends StatefulWidget {
  final String title;
  final String description;
  final List<WeddingTypeItemModel> items;

  const WeddingTypeSlider({
    super.key,
    required this.title,
    required this.description,
    required this.items,
  });

  @override
  State<WeddingTypeSlider> createState() => _WeddingTypeSliderState();
}

class _WeddingTypeSliderState extends State<WeddingTypeSlider> {
  final controller = PageController(viewportFraction: 0.85);
  Timer? timer;
  int index = 0;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      index++;
      controller.animateToPage(
        index % widget.items.length,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    const SizedBox(height: 12),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   child: Text(
          //     widget.description,
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(color: Colors.black54),
          //   ),
          // ),
          // const SizedBox(height: 30),

          SizedBox(
            height: 400,
            child: PageView.builder(
              controller: controller,
              itemCount: widget.items.length,
              itemBuilder: (_, i) {
                final item = widget.items[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: item.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.text,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
