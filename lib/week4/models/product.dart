class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewsCount;
  final String category;
  final String imageUrl;
  final bool inStock;
  final List<String> features;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewsCount,
    required this.category,
    required this.imageUrl,
    this.inStock = true,
    this.features = const [],
  });

  int get discountPercentage =>
      originalPrice > price ? (((originalPrice - price) / originalPrice) * 100).round() : 0;
}
