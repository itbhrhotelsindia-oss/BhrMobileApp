class BrandSection {
  final String title;
  final List<BrandBlock> blocks;

  BrandSection({
    required this.title,
    required this.blocks,
  });

  factory BrandSection.fromJson(Map<String, dynamic> json) {
    return BrandSection(
      title: json['title'] ?? '',
      blocks: (json['blocks'] as List? ?? [])
          .map((e) => BrandBlock.fromJson(e))
          .toList(),
    );
  }
}

class BrandBlock {
  final String text;
  final String imageUrl;

  BrandBlock({
    required this.text,
    required this.imageUrl,
  });

  factory BrandBlock.fromJson(Map<String, dynamic> json) {
    return BrandBlock(
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
