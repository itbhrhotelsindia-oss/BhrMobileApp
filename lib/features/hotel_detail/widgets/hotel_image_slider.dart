import 'dart:async';
import 'package:flutter/material.dart';

class HotelImageSlider extends StatefulWidget {
  final List<String> images;

  const HotelImageSlider({
    super.key,
    required this.images,
  });

  @override
  State<HotelImageSlider> createState() => _HotelImageSliderState();
}

class _HotelImageSliderState extends State<HotelImageSlider> {
  late final PageController _controller;
  late Timer _timer;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController();

    _timer = Timer.periodic(
      const Duration(seconds: 4),
          (_) {
        if (_controller.hasClients) {
          _currentPage++;

          if (_currentPage >= widget.images.length) {
            _currentPage = 0;
          }

          _controller.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// IMAGE SLIDER
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (i) {
              _currentPage = i;
            },
            itemBuilder: (_, i) {
              return Image.network(
                widget.images[i],
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (_, child, loading) {
                  if (loading == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image),
              );
            },
          ),
        ),

        /// DOT INDICATOR
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
                  (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == i ? 22 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == i
                      ? Colors.white
                      : Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
