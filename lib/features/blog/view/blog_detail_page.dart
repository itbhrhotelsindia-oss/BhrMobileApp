import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:photo_view/photo_view.dart';

import '../model/blog_detail_model.dart';

class BlogDetailPage extends StatelessWidget {
  final BlogDetailModel blog;

  const BlogDetailPage({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          blog.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Text(
              blog.description,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// IMAGE
            GestureDetector(
              onTap: () => _openImageViewer(context),
              child: Hero(
                tag: blog.imageUrl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    blog.imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// HTML CONTENT
            Html(
              data: blog.htmlContent,
              style: {
                "p": Style(
                  fontSize: FontSize(17),
                  lineHeight: LineHeight(1.7),
                ),
                "h2": Style(
                  fontSize: FontSize(22),
                  fontWeight: FontWeight.bold,
                  margin: Margins.only(top: 24, bottom: 12),
                ),
                "blockquote": Style(
                  backgroundColor: Colors.grey.shade100,
                  padding: HtmlPaddings.all(14),
                  border: Border(
                    left: BorderSide(color: Colors.amber, width: 4),
                  ),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openImageViewer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              PhotoView(
                imageProvider: NetworkImage(blog.imageUrl),
                heroAttributes:
                PhotoViewHeroAttributes(tag: blog.imageUrl),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close,
                      color: Colors.white, size: 32),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
