import 'dart:math';

import 'package:flora/constans/color.dart';
import 'package:flora/constans/constan.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/card/product_card.dart';
import 'package:flutter/material.dart';

class PromotionScreen extends StatefulWidget {
  final Map<String, String> promotion;

  const PromotionScreen({
    super.key,
    required this.promotion,
  });

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  List<ProductModel> items = [];

  @override
  void initState() {
    super.initState();
    items = DB.getFlowers();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));

    items.shuffle(Random());
    setState(() {
      items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = (screenWidth - 2 * AppSpace.xl - AppSpace.md) / 2;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SimpleAppHeader(widget.promotion['title']!),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: AppSpace.xl,
                  right: AppSpace.xl,
                  bottom: 12,
                ),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  boxShadow: const [AppStyle.boxShadowSm],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Image.asset(
                  widget.promotion['banner']!,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                width: 42,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.primary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpace.sm,
                  horizontal: 50,
                ),
                child: Text(
                  widget.promotion['desc']!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpace.md,
                    mainAxisSpacing: AppSpace.md,
                    childAspectRatio: AppConstant.productRatio,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: items[index],
                      width: itemWidth,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
