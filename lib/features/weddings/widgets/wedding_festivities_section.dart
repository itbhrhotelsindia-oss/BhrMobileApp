import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/festivities_model.dart';
import '../../../utils/expandable_text.dart';

class WeddingFestivitiesSection extends StatelessWidget {
  final FestivitiesModel festivities;

  const WeddingFestivitiesSection({super.key, required this.festivities});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// SECTION TITLE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            festivities.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 12),

        /// SECTION DESCRIPTION
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            festivities.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ),

        const SizedBox(height: 30),

        /// FESTIVITIES LIST
        ...festivities.festivitiesList.map((item) => _FestivityCard(item)),
      ],
    );
  }
}

class _FestivityCard extends StatelessWidget {
  final dynamic item;

  const _FestivityCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Text(
            item.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) =>
                  Container(height: 220, color: Colors.black12),
            ),
          ),

          const SizedBox(height: 8),

          /// DESCRIPTION
          ExpandableText(text: item.text),
        ],
      ),
    );
  }
}
