import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero, // 👈 important for header
        children: [
          /// HEADER
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColors.darkGold1),
            child: Row(
              children: [
                Icon(Icons.hotel, color: Colors.white, size: 40),
                SizedBox(width: 12),
                Text(
                  "BHR Hotels",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          _item(
            context,
            icon: Icons.description_outlined,
            title: "Blogs",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/blog");
            },
          ),

          _item(
            context,
            icon: Icons.local_offer_outlined,
            title: "Offers",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/offers");
            },
          ),

          _item(
            context,
            icon: Icons.info_outline,
            title: "About Us",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/about");
            },
          ),

          _item(
            context,
            icon: Icons.work_outline,
            title: "Careers",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/careers");
            },
          ),

          _item(
            context,
            icon: Icons.savings_outlined,
            title: "Why Book Direct",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/whyBookDirect");
            },
          ),

          _item(
            context,
            icon: Icons.event_note_outlined,
            title: "Manage Booking",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/manageBooking");
            },
          ),

          _item(
            context,
            icon: Icons.phone_outlined,
            title: "Contact Us",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/contact");
            },
          ),

          const Divider(height: 30),

          _item(
            context,
            icon: Icons.policy_outlined,
            title: "Terms and Conditions",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/termsAndCondition");
            },
          ),

          _item(
            context,
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/privacyPolicy");
            },
          ),

          _item(
            context,
            icon: Icons.assignment_return_outlined,
            title: "Refund and Cancellation",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/refundAndCancellation");
            },
          ),
        ],
      ),
    );
  }

  static Widget _item(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.darkGold1),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
