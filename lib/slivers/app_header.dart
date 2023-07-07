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
        collapsedChild: const CollapsedChild(),
        expandedChild: const ExpandedHeader(),
      ),
    );
  }
}

class AppPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget expandedChild;
  final Widget collapsedChild;

  AppPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.expandedChild,
    required this.collapsedChild,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isExpanded = shrinkOffset <= 8;

    return SizedBox.expand(
      child: isExpanded ? expandedChild : collapsedChild,
    );

    // return AnimatedCrossFade(
    //   duration: const Duration(milliseconds: 400),
    //   crossFadeState:
    //       isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    //   firstChild: expandedChild,
    //   secondChild: collapsedChild,
    // );
    // return AnimatedOpacity(
    //   duration: const Duration(milliseconds: 200),
    //   opacity: isExpanded ? 1.0 : 1.0,
    //   child: SizedBox.expand(
    //     child: isExpanded ? expandedChild : collapsedChild,
    //   ),
    // );
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(covariant AppPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        collapsedChild != oldDelegate.collapsedChild ||
        expandedChild != oldDelegate.expandedChild;
  }
}

class ExpandedHeader extends StatelessWidget {
  const ExpandedHeader({super.key});

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
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: AppSpace.xs),
                          child: Text(
                            'Hi, Nhatdote!',
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
