import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constans/color.dart';

class AppIndicator extends StatelessWidget {
  final int length;
  final int index;

  const AppIndicator({super.key, required this.length, required this.index});

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: index,
      count: length,
      effect: const ExpandingDotsEffect(
        dotWidth: 9,
        dotHeight: 9,
        spacing: 6,
        expansionFactor: 4.2,
        activeDotColor: AppColor.primary,
        dotColor: AppColor.neutral40,
      ),
    );
  }
}
