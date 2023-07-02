import 'package:flora/constans/asset.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/db.dart';
import 'package:flora/widgets/slider.dart';
import 'package:flutter/material.dart';

import '../../constans/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        HeaderWidget(),
        PromotionWidget(),
      ],
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
  PageController controller =
      PageController(initialPage: 1, viewportFraction: 0.7);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);

    return SizedBox(
      height: media.size.width * 0.6,
      child: PageView.builder(
        controller: controller,
        itemCount: items.length,
        onPageChanged: (value) => setState(() => currentIndex = value),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
            child: Image.asset(
              items[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
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
