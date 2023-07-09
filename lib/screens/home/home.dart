import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flora/constans/constan.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/routes.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/card/product_card.dart';
import 'package:flora/widgets/card/shop_card.dart';
import 'package:flora/widgets/category_slider.dart';
import 'package:flora/widgets/indicator.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> features = DB.features;
  List<ShopModel> deal83 = DB.shopList;
  List<ShopModel> birthday = DB.shopList;
  List<ProductModel> flowers = DB.getFlowers();

  @override
  void initState() {
    super.initState();

    deal83.shuffle(Random());
    birthday.shuffle(Random());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
      child: CustomScrollView(
        slivers: [
          const SliverAppHeader(),
          const SliverToBoxAdapter(
            child: PromotionWidget(),
          ),
          SliverList.list(
            children: [
              const SizedBox(height: AppSpace.xl),
              FeatureWidget(features: features),
              const SizedBox(height: AppSpace.xl),
              CategorySlider(
                category: 'Deal dành riêng cho Mùng 8/3',
                items: deal83,
                type: 'shop',
                builder: (item, {double? width}) => AspectRatio(
                  aspectRatio: AppConstant.shopRatio,
                  child: ShopCard(
                    width: width,
                    shop: item,
                  ),
                ),
              ),
              const SizedBox(height: AppSpace.xl),
              CategorySlider(
                category: 'Shop tặng Sinh nhật Người thương',
                items: birthday,
                type: 'shop',
                builder: (item, {double? width}) => AspectRatio(
                  aspectRatio: AppConstant.shopRatio,
                  child: ShopCard(
                    width: width,
                    shop: item,
                  ),
                ),
              ),
              const SizedBox(height: AppSpace.xl),
              CategorySlider(
                category: 'Sản phẩm thịnh hành',
                items: flowers,
                type: 'product',
                builder: (item, {double? width}) => AspectRatio(
                  aspectRatio: AppConstant.productRatio,
                  child: ProductCard(
                    width: width,
                    product: item,
                  ),
                ),
              ),
              const SizedBox(height: AppSpace.xl),
            ],
          ),
        ],
      ),
    );
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

class FeatureWidget extends StatelessWidget {
  final List<Map<String, String>> features;

  const FeatureWidget({
    super.key,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: features.map((h) {
        return InkWell(
          onTap: () => Navigator.pushNamed(context, h['route']!),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(AppSpace.xs),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [AppStyle.boxShadowSm],
                ),
                child: Image.asset(
                  h['icon']!,
                  height: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(h['label']!),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
