import 'package:flutter/material.dart';

import '../constans/color.dart';

class DiscountFlag extends StatelessWidget {
  final int discount;

  const DiscountFlag({
    super.key,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          width: 44,
          decoration: const BoxDecoration(
            color: AppColor.accent,
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'giảm\n',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '$discount%',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(width: 22, color: AppColor.accent),
              right: BorderSide(width: 22, color: AppColor.accent),
              bottom: BorderSide(width: 6, color: Colors.transparent),
            ),
          ),
        ),
      ],
    );
  }
}
