import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/widgets/discount_flag.dart';
import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  final String distance;
  final String name;
  final double star;
  final String evaluation;
  final String image;
  final double? width;
  final int? discount;

  const ShopCard({
    super.key,
    required this.distance,
    required this.name,
    required this.star,
    required this.evaluation,
    required this.image,
    this.width,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    double _width = width ?? 0;

    if (_width == 0) {
      final Size size = MediaQuery.of(context).size;
      _width = (size.width - 100) / 2;
    }

    Widget discountFlag =
        discount == null ? Container() : DiscountFlag(discount: discount!);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          width: _width,
          height: _width * 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: const [AppStyle.boxShadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: _width - 12,
                  height: _width * 0.8,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(distance, style: AppStyle.textHint),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  name,
                  style: AppStyle.textLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
                child: Row(
                  children: [
                    Image.asset(
                      Asset.iconStarSolid,
                      color: const Color(0xFFF7B22C),
                      height: 16,
                      width: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        "$star",
                        style: const TextStyle(
                            fontSize: AppStyle.fontSizeSm,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColor.neutral40,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "$evaluation Đánh giá",
                      style: const TextStyle(fontSize: AppStyle.fontSizeSm),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 16,
          child: discountFlag,
        ),
      ],
    );
  }
}
