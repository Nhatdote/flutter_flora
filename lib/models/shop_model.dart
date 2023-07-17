class ShopModel {
  ShopModel({
    required this.id,
    required this.distance,
    required this.name,
    required this.star,
    required this.evaluation,
    required this.image,
    this.discount,
  });

  final int id;
  final String distance;
  final String name;
  final double star;
  final String evaluation;
  final String image;
  final int? discount;
}
