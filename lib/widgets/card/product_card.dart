import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/shared/functions.dart';
import 'package:flutter/material.dart';
import '../discount_flag.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final double? width;

  const ProductCard({
    super.key,
    required this.product,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        width != null ? width! : (MediaQuery.of(context).size.width - 60) / 2;
    double rootPrice = 0.0;

    if (product.discount != null) {
      rootPrice = product.price + product.price * product.discount! / 100;
    }

    Widget discountFlag = product.discount == null
        ? Container()
        : DiscountFlag(discount: product.discount!);

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
                width: cardWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  product.image,
                  height: cardWidth - 12,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  product.name,
                  style: AppStyle.textLabel.copyWith(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Text(
                        Fs.vndFormat(product.price),
                        style: AppStyle.textLabel,
                      ),
                      const Spacer(),
                      rootPrice == 0
                          ? Container()
                          : Text(
                              Fs.vndFormat(rootPrice),
                              style: AppStyle.textHint.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                    ],
                  )),
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
                        "${product.star}",
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
                      "${product.sold} Đã bán",
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

class ProductModel {
  final String image;
  final String name;
  final double price;
  final double star;
  final int sold;
  final int? discount;

  ProductModel({
    required this.image,
    required this.name,
    required this.price,
    required this.star,
    required this.sold,
    this.discount,
  });
}
