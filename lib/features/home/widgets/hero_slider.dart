import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../booking/view/booking_search_page.dart';

class HeroSlider extends StatelessWidget {
  final List<String> images;
  final double height;

  const HeroSlider({
    super.key,
    required this.images,
    this.height = 320,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          /// IMAGE SLIDER
          AutoSlider(
            images: images,
            height: 320,
          ),

          /// DARK OVERLAY
          Container(
            color: Colors.black.withOpacity(0.25),
          ),

          // /// 🔹 TOP ICONS
          // Positioned(
          //   top: 20,
          //   right: 20,
          //   child: Row(
          //     children: [
          //       _circleIcon(
          //         icon: Icons.local_offer,
          //         onTap: () {
          //           // TODO: navigate to offers tab
          //         },
          //       ),
          //       const SizedBox(width: 12),
          //       _circleIcon(
          //         icon: Icons.person,
          //         onTap: () {
          //           // TODO: navigate to profile tab
          //         },
          //       ),
          //     ],
          //   ),
          // ),

          /// 🔹 BOOK NOW BUTTON
          Positioned(
            bottom: 20,
            left: 120,
            right: 120,
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.goldBtnGradient,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: ElevatedButton(
                onPressed: () { Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingSearchPage(),
                  ),
                );},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  "BOOK NOW",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            ,
          ),
        ],
      ),
    );
  }

  /// reusable round icon
  Widget _circleIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}

class AutoSlider extends StatefulWidget {
  final List<String> images;
  final double height;

  const AutoSlider({
    super.key,
    required this.images,
    this.height = 320,
  });

  @override
  State<AutoSlider> createState() => _AutoSliderState();
}

class _AutoSliderState extends State<AutoSlider> {
  final PageController _controller = PageController();
  int _current = 0;

  @override
  void initState() {
    super.initState();

    /// auto slide every 4 seconds
    Future.delayed(const Duration(seconds: 3), _autoSlide);
  }

  void _autoSlide() {
    if (!mounted) return;

    _current++;

    if (_current >= widget.images.length) {
      _current = 0;
    }

    _controller.animateToPage(
      _current,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 4), _autoSlide);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.images.length,
        itemBuilder: (_, index) {
          return CachedNetworkImage(
            imageUrl: widget.images[index],
            fit: BoxFit.cover,
            width: double.infinity,
            memCacheWidth: 1200,
            placeholder: (_, __) =>
                Container(color: Colors.black12),
            errorWidget: (_, __, ___) =>
            const Icon(Icons.broken_image),
          );
        },
      ),
    );
  }
}
