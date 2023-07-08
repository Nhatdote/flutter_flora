import 'package:flutter/material.dart';

import '../constans/asset.dart';
import '../constans/color.dart';
import '../constans/space.dart';
import '../constans/style.dart';

class SliverAppHeader extends StatelessWidget {
  const SliverAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: AppPersistentHeaderDelegate(
        minHeight: 110,
        maxHeight: 200,
      ),
    );
  }
}

class AppPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;

  AppPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isExpanded = shrinkOffset <= 25;

    return SizedBox.expand(
      child: ExpandedHeader(isExpanded),
    );
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(covariant AppPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}

class ExpandedHeader extends StatelessWidget {
  final bool isExpanded;

  const ExpandedHeader(
    this.isExpanded, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget AnimatedText = Padding(
      padding: const EdgeInsets.only(left: AppSpace.xs),
      child: AnimatedAlign(
        alignment: !isExpanded ? Alignment.center : Alignment.topLeft,
        duration: const Duration(milliseconds: 200),
        child: AnimatedDefaultTextStyle(
          style: !isExpanded
              ? AppStyle.textHeading3.copyWith(color: Colors.white)
              : const TextStyle(color: Colors.white),
          duration: const Duration(milliseconds: 200),
          child: Text(
            'Hi, Nhatdote!',
            textAlign: !isExpanded ? TextAlign.center : TextAlign.left,
          ),
        ),
      ),
    );

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
          !isExpanded
              ? Container()
              : Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    Asset.headerSmoke2,
                    fit: BoxFit.cover,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpace.xl,
              right: AppSpace.xl,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpace.xs),
                        child: Image.asset(Asset.logo, width: 25),
                      ),
                      Expanded(child: AnimatedText),
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
                  SizedBox(height: !isExpanded ? 0 : AppSpace.md),
                  !isExpanded
                      ? Container()
                      : TextField(
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(Asset.iconSearch),
                            hintText: 'Tìm kiếm sản phẩm ở đâu...',
                            isDense: false,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide:
                                  const BorderSide(color: AppColor.neutral10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide:
                                  const BorderSide(color: AppColor.primary),
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

class CollapsedChild extends StatelessWidget {
  const CollapsedChild({super.key});

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
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpace.xl,
              right: AppSpace.xl,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpace.xs),
                        child: Image.asset(Asset.logo, width: 25),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: AppSpace.xs),
                          child: Text(
                            'Hi, Nhatdote!',
                            textAlign: TextAlign.center,
                            style: AppStyle.textHeading3.copyWith(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
