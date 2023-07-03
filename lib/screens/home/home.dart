import 'package:carousel_slider/carousel_slider.dart';
import 'package:flora/constans/asset.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/db.dart';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HeaderWidget(),
          const PromotionWidget(),
          Padding(
            padding: const EdgeInsets.only(top: AppSpace.xl),
            child: Row(
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
  final List<String> items = DB.promotions;
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
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) =>
                setState(() => currentIndex = index),
          ),
          items: items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Image.asset(
                  i,
                  fit: BoxFit.cover,
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

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.primary,
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              Asset.headerSmoke1,
              fit: BoxFit.cover,
              width: 120,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Image.asset(
              Asset.headerSmoke2,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpace.xl),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpace.xs),
                        child: Image.asset(Asset.logo, width: 25),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: AppSpace.xs),
                          child: Text(
                            'Hi, Hong Ngoc!',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        Asset.iconShoppingBasket,
                        color: Colors.white,
                      ),
                      const SizedBox(width: AppSpace.xs),
                      Image.asset(
                        Asset.iconComments,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpace.md),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(Asset.iconSearch),
                      hintText: 'Tìm kiếm sản phẩm ở đâu...',
                      isDense: false,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: AppColor.neutral10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: AppColor.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
