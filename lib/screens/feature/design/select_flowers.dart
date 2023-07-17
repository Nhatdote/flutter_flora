import 'package:flora/constans/color.dart';
import 'package:flora/constans/constant.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/getx/design_state.dart';
import 'package:flora/models/product_model.dart';
import 'package:flora/routes.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/button.dart';
import 'package:flora/widgets/card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignSelectFlowersScreen extends StatefulWidget {
  const DesignSelectFlowersScreen({super.key});

  @override
  State<DesignSelectFlowersScreen> createState() =>
      _DesignSelectFlowersScreenState();
}

class _DesignSelectFlowersScreenState extends State<DesignSelectFlowersScreen> {
  final DesignState state = Get.find<DesignState>();
  final List<ProductModel> items = DB.getFlowers(shuffle: false);
  late Set<int> selectedIds = {};
  late bool btnDisabled = true;

  @override
  void initState() {
    super.initState();
    selectedIds = state.flowerIds.keys.map((e) => e as int).toSet();
    btnDisabled = state.flowerIds.isEmpty;
  }

  void onSelected(id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }

    setState(() {
      selectedIds = selectedIds;
      btnDisabled = selectedIds.isEmpty;
    });

    if (state.flowerIds.containsKey(id)) {
      state.flowerIds.remove(id);
    } else {
      state.flowerIds[id] = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const SimpleAppHeader('Thiết kế'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpace.xl,
              right: AppSpace.xl,
              bottom: AppSpace.xl,
            ),
            child: Row(
              children: [
                Text(state.shop.value!.name),
                const Padding(
                  padding: EdgeInsets.only(left: 4, right: 4, top: 1),
                  child: Icon(Icons.chevron_right_rounded),
                ),
                const Text('Chọn hoa')
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSpace.md,
                  crossAxisSpacing: AppSpace.md,
                  childAspectRatio: AppConstant.productRatio,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  ProductModel item = items[index];
                  bool isChecked = selectedIds.contains(item.id);

                  return InkWell(
                    onTap: () => onSelected(item.id),
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 2,
                            left: index % 2 == 0 ? 2 : 0,
                          ),
                          child: ProductCard(product: item),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: IgnorePointer(
                            ignoring: true,
                            child: Checkbox(
                              fillColor: MaterialStateColor.resolveWith((_) {
                                return AppColor.primary;
                              }),
                              value: isChecked,
                              onChanged: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 30,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              boxShadow: const [AppStyle.boxShadowSm],
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: AppButton(
              label: 'Tiếp tục',
              disable: btnDisabled,
              onTab: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.designSelectWrap,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
