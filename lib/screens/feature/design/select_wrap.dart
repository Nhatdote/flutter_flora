import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/getx/design_state.dart';
import 'package:flora/models/arrangement_model.dart';
import 'package:flora/models/wrap_model.dart';
import 'package:flora/routes.dart';
import 'package:flora/shared/functions.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/button.dart';

class DesignSelectWrapScreen extends StatefulWidget {
  const DesignSelectWrapScreen({super.key});

  @override
  State<DesignSelectWrapScreen> createState() => _DesignSelectWrapScreenState();
}

class _DesignSelectWrapScreenState extends State<DesignSelectWrapScreen> {
  DesignState state = Get.find<DesignState>();
  final List<WrapModel> wraps = DB.wraps;
  final List<ArrangementModel> arrangements = DB.arrangements;
  int? wrapSelected;
  int? arrangeSelected;
  bool btnDisalbed = true;

  @override
  void initState() {
    super.initState();
    wrapSelected = state.wrap.value;
    arrangeSelected = state.arrangement.value;
    btnDisalbed = wrapSelected == null || arrangeSelected == null;
  }

  void onChange(String type, int? value) {
    setState(() {
      wrapSelected = type == 'wrap' ? value : wrapSelected;
      arrangeSelected = type != 'wrap' ? value : arrangeSelected;
      btnDisalbed = wrapSelected == null || arrangeSelected == null;
    });

    state.wrap.value = wrapSelected;
    state.arrangement.value = arrangeSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const SimpleAppHeader('Thiết kế'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SectionWidget(
                    onChanged: (value) => onChange('wrap', value),
                    selected: wrapSelected,
                    title: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpace.xxl),
                      child: Row(
                        children: [
                          Text(state.shop.value!.name),
                          const Padding(
                            padding: EdgeInsets.only(left: 4, right: 4, top: 1),
                            child: Icon(Icons.chevron_right_rounded),
                          ),
                          const Text('Chọn giấy gói hoa')
                        ],
                      ),
                    ),
                    items: wraps,
                  ),
                  const SizedBox(height: AppSpace.xxl),
                  SectionWidget(
                    onChanged: (value) => onChange('arrange', value),
                    selected: arrangeSelected,
                    title: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpace.xxl),
                      child: Row(
                        children: [
                          Text(state.shop.value!.name),
                          const Padding(
                            padding: EdgeInsets.only(left: 4, right: 4, top: 1),
                            child: Icon(Icons.chevron_right_rounded),
                          ),
                          const Text('Chọn kiểu bó hoa')
                        ],
                      ),
                    ),
                    items: arrangements,
                  ),
                ],
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
              disable: btnDisalbed,
              onTab: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.designCart,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    required this.selected,
  });

  final Widget title;
  final List<dynamic> items;
  final void Function(int) onChanged;
  final int? selected;

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 60) / 2;

    return Column(
      children: [
        title,
        const SizedBox(height: 4),
        SizedBox(
          height: width * 1.28,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final item = items[index];

              return Stack(
                children: [
                  GestureDetector(
                    onTap: () => onChanged(item.id),
                    child: ItemWidget(
                      index: index,
                      length: items.length,
                      item: item,
                      width: width,
                    ),
                  ),
                  Positioned(
                    // background for radio
                    right: index == items.length - 1 ? AppSpace.xl + 15 : 15,
                    top: 20,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    right: index == items.length - 1 ? AppSpace.xl : 0,
                    top: 5,
                    child: IgnorePointer(
                      ignoring: true,
                      child: Radio(
                        value: item.id,
                        groupValue: selected,
                        onChanged: null,
                        fillColor: MaterialStateColor.resolveWith((_) {
                          return AppColor.primary;
                        }),
                        activeColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.index,
    required this.length,
    required this.item,
    required this.width,
  });

  final int index;
  final int length;
  final dynamic item;
  final double width;

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = const EdgeInsets.symmetric(
      vertical: AppSpace.xs,
    );

    if (index == 0) {
      padding = const EdgeInsets.only(
        left: AppSpace.xl,
        top: AppSpace.xs,
        bottom: AppSpace.xs,
      );
    } else if (index == length - 1) {
      padding = const EdgeInsets.only(
        right: AppSpace.xl,
        top: AppSpace.xs,
        bottom: AppSpace.xs,
      );
    }

    return Padding(
      padding: padding,
      child: Container(
        padding: const EdgeInsets.all(6),
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: const [AppStyle.boxShadowSm]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                item.image,
                width: width,
                height: width * 0.8,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: AppSpace.xs),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                item.title,
                style: AppStyle.textLabel,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                Fs.vndFormat(item.price),
                style: AppStyle.textLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
