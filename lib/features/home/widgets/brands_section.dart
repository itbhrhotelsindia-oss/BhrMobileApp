import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/home_model.dart';

class BrandsSection extends StatelessWidget {
  final BrandSection section;

  const BrandsSection({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE9E6E6),
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Text(
            section.title,
            style: const TextStyle(
              fontSize: 34,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 40),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: section.blocks.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (_, i) {
              final brand = section.blocks[i];

              return Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: brand.imageUrl,
                          fit: BoxFit.contain,
                          memCacheWidth: 600,
                          placeholder: (_, __) =>
                          const SizedBox(),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        brand.text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
