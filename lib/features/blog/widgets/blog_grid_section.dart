import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/blog_list_section.dart';
import '../model/blog_item_model.dart';
import '../view/blog_detail_page.dart';
import 'package:bhrhotel/core/theme/app_colors.dart';

class BlogGridSection extends StatelessWidget {
  final BlogListSection section;

  const BlogGridSection({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Text(
            section.title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          /// DESCRIPTION
          Text(
            section.description,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 30),

          /// GRID
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: section.blogsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final blog = section.blogsList[index];

              if (blog.promo) {
                return _PromoCard(blog: blog);
              }

              return _BlogCard(blog: blog);
            },
          ),
        ],
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final BlogItemModel blog;

  const _BlogCard({required this.blog});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlogDetailPage(
              blog: blog.toDetailModel(),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: CachedNetworkImage(
                imageUrl: blog.imageUrl,
                height: 145,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: Colors.black12),
                errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0,20,0,0),
              child: Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    blog.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// SUBTITLE
                  Text(
                    blog.subtitle ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final BlogItemModel blog;

  const _PromoCard({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: AppColors.goldBtnGradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (blog.subtitle != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                blog.subtitle!,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),

          const SizedBox(height: 16),

          Text(
            blog.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.darkGold1,
            ),
            onPressed: () {},
            child: const Text("Explore"),
          ),
        ],
      ),
    );
  }
}
