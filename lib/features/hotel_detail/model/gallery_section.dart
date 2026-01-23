class GallerySection {
  final List<String> images;

  GallerySection({
    required this.images,
  });

  factory GallerySection.fromJson(Map<String, dynamic> json) {
    return GallerySection(
      images: List<String>.from(json['images'] ?? []),
    );
  }
}
