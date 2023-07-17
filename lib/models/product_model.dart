class ProductModel {
  final int id;
  final String image;
  final String name;
  final double price;
  final double star;
  final int sold;
  int? discount;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.star,
    required this.sold,
    this.discount,
  });
}
