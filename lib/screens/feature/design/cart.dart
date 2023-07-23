import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/constant.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/getx/design_state.dart';
import 'package:flora/models/arrangement_model.dart';
import 'package:flora/models/product_model.dart';
import 'package:flora/models/wrap_model.dart';
import 'package:flora/routes.dart';
import 'package:flora/shared/functions.dart';
import 'package:flora/shared/toast.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignCartScreen extends StatefulWidget {
  const DesignCartScreen({super.key});

  @override
  State<DesignCartScreen> createState() => _DesignCartScreenState();
}

class _DesignCartScreenState extends State<DesignCartScreen> {
  final DesignState state = Get.find<DesignState>();
  late WrapModel wrap;
  late ArrangementModel arrange;
  late List<ProductModel> items;

  @override
  void initState() {
    super.initState();

    wrap = DB.wraps.firstWhere((h) => h.id == state.wrap.value);
    arrange =
        DB.arrangements.firstWhere((h) => h.id == state.arrangement.value);

    items =
        DB.getFlowerByIds(state.flowerIds.keys.map((h) => h as int).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppHeader('Thiết kế'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpace.xl, vertical: AppSpace.sm),
                    child: Row(
                      children: [
                        const Text('Sản phẩm', style: AppStyle.textLabel),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.popUntil(
                                context,
                                (route) =>
                                    route.settings.name ==
                                    AppRoute.designSelectFlowers);
                          },
                          child: const Text(
                            'Thêm sản phẩm',
                            style: TextStyle(
                              color: AppColor.primary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  FlowerWidget(
                    flowers: state.flowerIds,
                    items: items,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpace.xl, vertical: AppSpace.sm),
                    child: Row(
                      children: [
                        const Text('Giấy gói', style: AppStyle.textLabel),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.popUntil(
                                context,
                                (route) =>
                                    route.settings.name ==
                                    AppRoute.designSelectWrap);
                          },
                          child: const Text(
                            'Sửa',
                            style: TextStyle(
                              color: AppColor.primary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  WrapWidget(
                    item: wrap,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpace.xl, vertical: AppSpace.sm),
                    child: Row(
                      children: [
                        const Text('Kiểu bó', style: AppStyle.textLabel),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.popUntil(
                                context,
                                (route) =>
                                    route.settings.name ==
                                    AppRoute.designSelectWrap);
                          },
                          child: const Text(
                            'Sửa',
                            style: TextStyle(
                              color: AppColor.primary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  WrapWidget(
                    item: arrange,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 30,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              boxShadow: const [AppStyle.boxShadowSm],
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Thành tiền',
                      style: AppStyle.textLabel,
                    ),
                    const Spacer(),
                    Obx(() {
                      double total = items.fold<double>(0, (previous, h) {
                        return previous +
                            h.price *
                                (state.flowerIds.containsKey(h.id)
                                    ? state.flowerIds[h.id]
                                    : 0);
                      });

                      total += wrap.price + arrange.price;

                      return Text(
                        Fs.vndFormat(total),
                        style: AppStyle.title.copyWith(
                          color: AppColor.primary,
                        ),
                      );
                    }),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: AppSpace.md,
                    bottom: AppSpace.xxl,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColor.neutral10,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Material(
                      child: InkWell(
                        onTap: () {
                          Toast.show('OK!');
                        },
                        borderRadius: BorderRadius.circular(16),
                        splashColor: AppColor.primary50,
                        child: Ink(
                          width: AppConstant.btnHeight,
                          height: AppConstant.btnHeight,
                          decoration: BoxDecoration(
                            color: AppColor.primary20,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.asset(
                            Asset.iconShoppingBasket,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpace.md),
                    Expanded(
                      child: AppButton(
                        label: 'Thanh toán',
                        disable: false,
                        onTap: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   AppRoute.designSelectWrap,
                          // );
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FlowerWidget extends StatelessWidget {
  const FlowerWidget({
    super.key,
    required this.flowers,
    required this.items,
  });

  final Map<dynamic, dynamic> flowers;
  final List<ProductModel> items;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.xl,
          vertical: 4,
        ),
        child: Column(
          children: flowers.keys.map((id) {
            final ProductModel item = items.firstWhere(
              (element) => element.id == id,
            );

            return Container(
              height: 86,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: AppSpace.xs,
              ),
              margin: const EdgeInsets.only(bottom: AppSpace.sm),
              decoration: BoxDecoration(
                boxShadow: const [AppStyle.boxShadowSm],
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      item.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: AppStyle.textLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            IconBtnWidget(
                              icon: 'minus',
                              isActive: false,
                              itemId: item.id,
                            ),
                            Obx(
                              () => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpace.xs,
                                ),
                                width: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  '${flowers[item.id]}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            IconBtnWidget(
                              icon: 'plus',
                              isActive: true,
                              itemId: item.id,
                            ),
                            const Spacer(),
                            Text(
                              Fs.vndFormat(item.price),
                              style: AppStyle.textLabel,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class IconBtnWidget extends StatelessWidget {
  const IconBtnWidget({
    super.key,
    required this.icon,
    required this.isActive,
    required this.itemId,
  });

  final String icon;
  final bool isActive;
  final int itemId;

  @override
  Widget build(BuildContext context) {
    DesignState state = Get.find<DesignState>();

    final Map<String, IconData> iconMap = {
      'minus': Icons.remove_rounded,
      'plus': Icons.add_rounded,
    };

    return Material(
      child: InkWell(
        onTap: () {
          if (icon == 'plus') {
            state.incQuantity(itemId);
          } else {
            state.decQuantity(itemId);
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isActive ? AppColor.primary : AppColor.neutral40,
          ),
          child: Container(
            width: 24,
            height: 24,
            padding: const EdgeInsets.all(2),
            alignment: Alignment.center,
            child: Icon(
              iconMap[icon],
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class WrapWidget extends StatelessWidget {
  const WrapWidget({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.xl,
        vertical: 4,
      ),
      child: Container(
        height: 86,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: AppSpace.xs,
        ),
        margin: const EdgeInsets.only(bottom: AppSpace.sm),
        decoration: BoxDecoration(
          boxShadow: const [AppStyle.boxShadowSm],
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppStyle.textLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    Fs.vndFormat(item.price),
                    style: AppStyle.textLabel,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
