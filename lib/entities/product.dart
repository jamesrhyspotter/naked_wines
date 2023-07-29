class Product {
  final int id;
  final String name;
  final int price;
  final String productImageUrl;

  String? description;
  bool? inStock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.productImageUrl,
  });
}
