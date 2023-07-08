import 'package:flora/constans/style.dart';
import 'package:flutter/material.dart';
import '../constans/space.dart';

class CategorySlider extends StatelessWidget {
  final String? category;
  final List<dynamic> items;
  final Widget Function(dynamic item, {double? width}) builder;
  final String type;

  const CategorySlider({
    super.key,
    this.category,
    required this.items,
    required this.builder,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
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

    double width = (MediaQuery.of(context).size.width - 60) / 2;
    double height;

    if (type == 'product') {
      height = width * 1.5;
    } else {
      height = width * 1.35;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        SizedBox(
          height: height,
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
