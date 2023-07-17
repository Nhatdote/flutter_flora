import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/models/shop_model.dart';
import 'package:flora/widgets/discount_flag.dart';
import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  final ShopModel shop;
  final double? width;

  const ShopCard({
    super.key,
    required this.shop,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        width != null ? width! : (MediaQuery.of(context).size.width - 60) / 2;

    Widget discountFlag = shop.discount == null
        ? Container()
        : DiscountFlag(discount: shop.discount!);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          width: cardWidth,
          height: double.infinity,
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
                  shop.image,
                  fit: BoxFit.cover,
                  width: cardWidth - 12,
                  height: cardWidth * 0.8,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(shop.distance, style: AppStyle.textHint),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  shop.name,
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
                        "${shop.star}",
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
                      "${shop.evaluation} Đánh giá",
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
