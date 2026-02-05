import 'package:flutter/material.dart';
import '../model/event_category_model.dart';
import '../../../core/theme/app_colors.dart';

class EventCategoryCard extends StatelessWidget {
  final EventCategoryModel category;
  final bool selected;
  final VoidCallback onTap;

  const EventCategoryCard({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          // color: selected
          //     ? const Color(0xffb7832f)
          //     : Colors.grey.shade100,
          color: AppColors.lightGold,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(14)),
              child: Image.network(
                category.image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                category.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  // color: selected ? Colors.white : Colors.black87,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
