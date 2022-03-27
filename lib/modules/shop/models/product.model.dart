class Product {
  String id;
  String name;
  List<String> images;
  String description;
  List<String> reviews;
  double rating;
  bool isFeatured;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.images,
    required this.description,
    required this.rating,
    required this.price,
    this.reviews = const [],
    this.isFeatured = false,
  });
}
