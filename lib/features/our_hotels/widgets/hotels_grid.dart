import 'package:flutter/material.dart';
import '../model/city_model.dart';
import 'city_card.dart';

class HotelsGrid extends StatelessWidget {
  final List<CityModel> cities;

  const HotelsGrid({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: 1.2,
      ),
      itemCount: cities.length,
      itemBuilder: (_, i) {
        return CityCard(city: cities[i]);
      },
    );
  }
}
