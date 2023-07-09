import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/routes.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/card/shop_card.dart';
import 'package:flutter/material.dart';

class DesignSelectShopScreen extends StatefulWidget {
  const DesignSelectShopScreen({super.key});

  @override
  State<DesignSelectShopScreen> createState() => _DesignSelectShopScreenState();
}

class _DesignSelectShopScreenState extends State<DesignSelectShopScreen> {
  List<ShopModel> shops = DB.shopList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const SimpleAppHeader('Thiết kế'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: AppSpace.md, left: AppSpace.xl),
            child: Text(
              'Chọn cửa hàng để thiết kế hoa dành cho bạn',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final ShopModel shop = shops[index];

                  return InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoute.designSelectFlowers,
                      arguments: {'shop_id': shop.id},
                    ),
                    splashColor: Colors.black38,
                    borderRadius: BorderRadius.circular(15),
                    // radius: 1000,
                    child: Ink(
                      decoration: BoxDecoration(
                        boxShadow: const [AppStyle.boxShadowSm],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpace.md),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Image.asset(
                                shop.image,
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpace.sm,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      shop.name,
                                      style: AppStyle.textHeading2,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          Asset.iconStarSolid,
                                          color: const Color(0xFFF7B22C),
                                          height: 16,
                                          width: 16,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Text(
                                            "${shop.star}",
                                            style: const TextStyle(
                                                fontSize: AppStyle.fontSizeSm,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 3,
                                            left: AppSpace.xs,
                                            right: AppSpace.xs,
                                          ),
                                          alignment: Alignment.center,
                                          width: 3,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            color: AppColor.neutral40,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        Text("${shop.evaluation} Đánh giá"),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 3,
                                            left: AppSpace.xs,
                                            right: AppSpace.xs,
                                          ),
                                          alignment: Alignment.center,
                                          width: 3,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            color: AppColor.neutral40,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        Text(shop.distance),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black38,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppSpace.xl),
                itemCount: shops.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
