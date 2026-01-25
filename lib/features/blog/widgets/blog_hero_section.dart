import 'package:flutter/material.dart';
import '../model/blog_model.dart';
class BlogHeroSection extends StatelessWidget {
  final BlogModel blog;

  const BlogHeroSection({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            blog.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            blog.description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
