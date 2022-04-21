class Product {
  String id;
  String name;
  String image;
  String description;
  List<String> reviews;
  double rating;
  bool isFeatured;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.rating,
    required this.price,
    this.reviews = const [],
    this.isFeatured = false,
  });
}
