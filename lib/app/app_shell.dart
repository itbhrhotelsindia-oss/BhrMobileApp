import 'package:flutter/material.dart';

import '../features/home/view/home_page.dart';
import '../features/our_hotels/view/our_hotels_page.dart';
import '../features/weddings/view/weddings_page.dart';
import '../features/blog/view/blog_page.dart';
import '../features/partner/view/partner_page.dart';
import '../features/event/view/events_page.dart';
import '../core/theme/app_colors.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final pages = const [
    HomePage(),
    OurHotelsPage(),
    WeddingsPage(),
    // BlogPage(),
    EventsPage(),
    PartnerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,

        /// ✅ BACKGROUND COLOR
        backgroundColor: AppColors.lightGold,

        /// ✅ ACTIVE ICON COLOR
        selectedItemColor: AppColors.darkGold1,

        /// ✅ INACTIVE ICON COLOR
        unselectedItemColor: Colors.grey.shade500,

        /// ✅ LABEL COLORS
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),

        /// ✅ ICON SIZE
        iconSize: 26,

        /// ✅ ELEVATION (shadow)
        elevation: 12,

        onTap: (i) => setState(() => index = i),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            label: "Hotels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.party_mode),
            label: "Weddings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: "Events",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake),
            label: "Partner With Us",
          ),
        ],
      ),
    );
  }
}
