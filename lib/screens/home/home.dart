import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flora/constans/asset.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/routes.dart';
import 'package:flora/slivers/app_header.dart';
import 'package:flora/widgets/card/product_card.dart';
import 'package:flora/widgets/card/shop_card.dart';
import 'package:flora/widgets/category_slider.dart';
import 'package:flora/widgets/indicator.dart';
import 'package:flutter/material.dart';
import '../../constans/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> features = DB.features;
  List<Map<String, dynamic>> deal83 = DB.shopList;
  List<Map<String, dynamic>> birthday = DB.shopList;
  List<ProductModel> flowers = DB.getFlowers();

  @override
  void initState() {
    super.initState();

    deal83.shuffle(Random());
    birthday.shuffle(Random());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppHeader(),
        const SliverToBoxAdapter(
          child: PromotionWidget(),
        ),
        SliverList.list(
          children: [
            const SizedBox(height: AppSpace.xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: features
                  .map(
                    (h) => FeatureWidghet(
                      label: h['label']!,
                      icon: h['icon']!,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: AppSpace.xl),
            CategorySlider(
              category: 'Deal dành riêng cho Mùng 8/3',
              items: deal83,
              builder: (item, {double? width}) => ShopCard(
                width: width,
                distance: item['distance'],
                name: item['name'],
                star: item['star'],
                evaluation: item['evaluation'],
                image: item['image'],
                discount: item['discount'],
              ),
            ),
            const SizedBox(height: AppSpace.xl),
            CategorySlider(
              category: 'Shop tặng Sinh nhật Người thương',
              items: birthday,
              builder: (item, {double? width}) => ShopCard(
                width: width,
                distance: item['distance'],
                name: item['name'],
                star: item['star'],
                evaluation: item['evaluation'],
                image: item['image'],
                discount: item['discount'],
              ),
            ),
            const SizedBox(height: AppSpace.xl),
            const SizedBox(height: AppSpace.xl),
          ],
        ),
        // SliverList.separated(
        //   itemCount: flowers.length,
        //   itemBuilder: (context, index) {
        //     return ProductCard(product: flowers[index]);
        //   },
        //   separatorBuilder: (context, index) =>
        //       const SizedBox(width: AppSpace.md),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ProductCard(product: flowers[index]);
            },
            childCount: flowers.length,
          ),
        ),
        // SliverPadding(
        //   padding: const EdgeInsets.all(AppSpace.xl),
        //   sliver: SliverGrid(
        //     delegate: SliverChildBuilderDelegate(
        //       (BuildContext context, int index) {
        //         return ProductCard(product: flowers[index]);
        //       },
        //       childCount: flowers.length,
        //     ),
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       mainAxisSpacing: AppSpace.md,
        //       crossAxisSpacing: AppSpace.md,
        //       childAspectRatio: 0.7,
        //     ),
        //   ),
        // )
      ],
    );

    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       const HeaderWidget(),
    //       const PromotionWidget(),
    //       const SizedBox(height: AppSpace.xl),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: features
    //             .map(
    //               (h) => FeatureWidghet(
    //                 label: h['label']!,
    //                 icon: h['icon']!,
    //               ),
    //             )
    //             .toList(),
    //       ),
    //       const SizedBox(height: AppSpace.xl),
    //       CategorySlider(
    //         category: 'Deal dành riêng cho Mùng 8/3',
    //         items: deal83,
    //         builder: (item, {double? width}) => ShopCard(
    //           width: width,
    //           distance: item['distance'],
    //           name: item['name'],
    //           star: item['star'],
    //           evaluation: item['evaluation'],
    //           image: item['image'],
    //           discount: item['discount'],
    //         ),
    //       ),
    //       const SizedBox(height: AppSpace.xl),
    //       CategorySlider(
    //         category: 'Shop tặng Sinh nhật Người thương',
    //         items: birthday,
    //         builder: (item, {double? width}) => ShopCard(
    //           width: width,
    //           distance: item['distance'],
    //           name: item['name'],
    //           star: item['star'],
    //           evaluation: item['evaluation'],
    //           image: item['image'],
    //           discount: item['discount'],
    //         ),
    //       ),
    //       const SizedBox(height: AppSpace.xl),
    // CategorySlider(
    //   category: 'Sản phẩm thịnh hành',
    //   items: flowers,
    //   builder: (item, {double? width}) => ProductCard(
    //     width: width,
    //     product: item,
    //   ),
    // ),
    // const SizedBox(height: AppSpace.xl),
    //     ],
    //   ),
    // );
  }
}

class PromotionWidget extends StatefulWidget {
  const PromotionWidget({super.key});

  @override
  State<PromotionWidget> createState() => _PromotionWidgetState();
}

class _PromotionWidgetState extends State<PromotionWidget> {
  final List<Map<String, String>> items = DB.promotions;
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.7,
            // autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) =>
                setState(() => currentIndex = index),
          ),
          items: items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoute.promotion,
                    arguments: {'promotion': i},
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: AppSpace.xl),
                    decoration: BoxDecoration(
                      boxShadow: const [AppStyle.boxShadowSm],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      i['banner']!,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        AppIndicator(length: items.length, index: currentIndex)
      ],
    );
  }
}

class FeatureWidghet extends StatelessWidget {
  final String label;
  final String icon;

  const FeatureWidghet({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(AppSpace.xs),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(
            icon,
            height: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(label),
        )
      ],
    );
  }
}
