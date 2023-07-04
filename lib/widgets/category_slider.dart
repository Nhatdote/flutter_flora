import 'package:flora/constans/style.dart';
import 'package:flutter/material.dart';
import '../constans/space.dart';

class CategorySlider extends StatelessWidget {
  final String? category;
  final List<Map<String, dynamic>> items;
  final Widget Function(dynamic item, {double? width}) builder;

  const CategorySlider({
    super.key,
    this.category,
    required this.items,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = (size.width - AppSpace.xl * 2 - AppSpace.sm * 2) / 2;

    Widget title = Container();
    if (category != null) {
      title = Padding(
        padding: const EdgeInsets.only(
          left: AppSpace.xl,
          right: AppSpace.xl,
        ),
        child: Row(
          children: [
            Text(
              category!,
              style: AppStyle.textHeading3,
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right_rounded,
              size: 32,
            )
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        SizedBox(
          height: width * 1.5,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(
              width: AppSpace.sm,
            ),
            itemBuilder: (context, index) {
              EdgeInsets padding = const EdgeInsets.symmetric(
                vertical: AppSpace.xs,
              );

              if (index == 0) {
                padding = const EdgeInsets.only(
                  left: AppSpace.xl,
                  top: AppSpace.xs,
                  bottom: AppSpace.xs,
                );
              } else if (index == items.length - 1) {
                padding = const EdgeInsets.only(
                  right: AppSpace.xl,
                  top: AppSpace.xs,
                  bottom: AppSpace.xs,
                );
              }

              return Padding(
                padding: padding,
                child: builder(items[index], width: width),
              );
            },
          ),
        ),
      ],
    );
  }
}
