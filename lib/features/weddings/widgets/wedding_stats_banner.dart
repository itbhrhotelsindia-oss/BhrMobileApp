import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../model/wedding_stats_model.dart';
import '../../../core/theme/app_colors.dart';

class WeddingStatsBanner extends StatelessWidget {
  final List<WeddingStatModel> stats;

  const WeddingStatsBanner({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(
        gradient: AppColors.goldBtnGradient,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats.map((e) {
          return Column(
            children: [
              Text(
                e.value,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                e.label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
