import 'package:flutter/material.dart';
import '../model/event_category_model.dart';
import 'event_category_card.dart';

class EventCategoryGrid extends StatelessWidget {
  final List<EventCategoryModel> categories;
  final String selectedKey;
  final ValueChanged<EventCategoryModel> onSelected;

  const EventCategoryGrid({
    super.key,
    required this.categories,
    required this.selectedKey,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.78,
        ),
        itemBuilder: (_, i) {
          final item = categories[i];

          return EventCategoryCard(
            category: item,
            selected: selectedKey == item.key,
            onTap: () => onSelected(item),
          );
        },
      ),
    );
  }
}
