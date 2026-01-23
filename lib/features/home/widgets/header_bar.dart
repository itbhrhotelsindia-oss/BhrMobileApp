import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  final bool scrolled;
  final VoidCallback onBook;

  const HeaderBar({
    super.key,
    required this.scrolled,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: scrolled ? Colors.white : Colors.transparent,
        boxShadow: scrolled
            ? [BoxShadow(color: Colors.black12, blurRadius: 8)]
            : [],
      ),
      child: Row(
        children: [
          // Image.asset(
          //   "assets/hotel-logo.jpeg",
          //   height: 60,
          // ),
          // const Spacer(),

          TextButton(
            onPressed: () {},
            child: const Text("Our Hotels"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Offers"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Events"),
          ),

          const SizedBox(width: 20),

          ElevatedButton(
            onPressed: onBook,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber.shade700,
              shape: const StadiumBorder(),
            ),
            child: const Text("BOOK NOW"),
          )
        ],
      ),
    );
  }
}
