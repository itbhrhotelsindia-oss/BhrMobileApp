import 'package:flutter/material.dart';
import '../model/popular_post_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../view/blog_detail_page.dart';

class BlogSidebarSection extends StatelessWidget {
  final PopularPostSection section;

  const BlogSidebarSection({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...section.postsList.map(
            (post) => ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlogDetailPage(
                      blog: post.toDetailModel(),
                    ),
                  ),
                );
              },
              contentPadding: EdgeInsets.zero,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: post.imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(post.title),
              subtitle: Text(""),
            ),
          ),
        ],
      ),
    );
  }
}
