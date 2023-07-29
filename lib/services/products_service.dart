import 'dart:math';

import '../entities/product.dart';

final _products = [
  Product(
      id: 1,
      name: 'Virgile Joly Bourret 2021',
      price: 1299,
      productImageUrl:
          'https://d1sixo6y2intz2.cloudfront.net/images/merchandising/content/wines/virgile-joly-bourret-2021/background.jpg'),
  Product(
      id: 2,
      name: 'Small & Small Marlborough Sauvignon Blanc 2022',
      price: 1599,
      productImageUrl:
          'https://d1sixo6y2intz2.cloudfront.net/images/merchandising/content/wines/small-and-small-marlborough-sauvignon-blanc-2022/background.jpg'),
  Product(
      id: 3,
      name: 'Fattori Pinot Grigio 2021',
      price: 999,
      productImageUrl:
          'https://d1sixo6y2intz2.cloudfront.net/images/merchandising/content/wines/fattori-pinot-grigio-2021/background.jpg'),
  Product(
      id: 4,
      name: 'Jen Pfeiffer The Rebel Riesling 2022',
      price: 1499,
      productImageUrl:
          'https://d1sixo6y2intz2.cloudfront.net/images/merchandising/content/wines/jen-pfeiffer-the-rebel-riesling-2022/background.jpg'),
  Product(
      id: 5,
      name: 'Villion Chardonnay 2021',
      price: 1799,
      productImageUrl:
          'https://d1sixo6y2intz2.cloudfront.net/images/merchandising/content/wines/villion-chardonnay-2021/background.jpg'),
  Product(
      id: 6,
      name: 'Monte Fitti Custoza Bianco 2022',
      price: 1399,
      productImageUrl:
          'https://d1sixo6y2intz2.cloudfront.net/images/merchandising/content/wines/monte-fitti-custoza-bianco-2022/background.jpg'),
  Product(
      id: 7,
      name: 'Villebois Sauvignon Blanc 2022',
      price: 1299,
      productImageUrl:
          'https://d1sixo6y2intz2.cloudfront.net/images/merchandising/content/wines/villebois-sauvignon-blanc-2022/background.jpg'),
];

class ProductsService {
  /// Fetches a list of all available products. Stock information and product
  /// descriptions aren't available when fetching products using this method.
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _products;
  }

  /// Fetches a single product. Stock information and product descriptions are
  /// available when fetching a product using this method.
  Future<Product> fetchProduct({
    required int id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (!_products.any((element) => element.id == id)) {
      throw 'Product not found';
    }

    final product = _products.firstWhere((element) => element.id == id);

    product.inStock = product.id % 3 == 0;
    product.description = 'A sweet and fruity wine.';

    return product;
  }

  /// Fetches a list of reviews for the given product.
  Future<List<String>> fetchProductReviews({
    required int productId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final reviewCount = Random().nextInt(10);

    return [
      for (var i = 0; i < reviewCount; i++) 'I really liked this wine',
    ];
  }
}
