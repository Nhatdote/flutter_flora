import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/models/product_model.dart';
import 'package:flora/shared/functions.dart';
import 'package:flora/widgets/button/app_button.dart';
import 'package:flutter/material.dart';

class ProductFavoriteCard extends StatelessWidget {
  const ProductFavoriteCard(this.product, {super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpace.md),
      height: 115,
      decoration: const BoxDecoration(
        boxShadow: [AppStyle.boxShadowSm],
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 65,
            height: 65,
            child: Image.asset(product.image),
          ),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: AppStyle.textLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Image.asset(
                      Asset.iconHeartSolid,
                      color: AppColor.accent,
                    )
                  ],
                ),
                Text(
                  'Đã bán: ${product.sold}',
                  style: const TextStyle(color: AppColor.neutral40),
                ),
                Row(
                  children: [
                    Text(
                      Fs.vndFormat(product.price),
                      style: AppStyle.textHeading3.copyWith(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 100,
                      child: AppButton(
                        size: 'medium',
                        label: 'Mua ngay',
                        onTap: () {},
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
