import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flora/api.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/models/product_model.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flutter/material.dart';
import '../../constans/constant.dart';
import '../../constans/space.dart';
import '../../widgets/card/product_card.dart';

class StrangeScreen extends StatefulWidget {
  const StrangeScreen({super.key});

  @override
  State<StrangeScreen> createState() => _StrangeScreenState();
}

class _StrangeScreenState extends State<StrangeScreen>
    with SingleTickerProviderStateMixin {
  List<ProductModel> items = [];
  List<Map<String, dynamic>> districts = [];
  int? districSeleted;
  bool isDistrictOpend = false;
  bool finding = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    items = DB.getFlowers();
    getDistricts();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> getDistricts() async {
    var api = await API.districts;

    setState(() {
      districts = api;
    });
  }

  Future<void> onDistrictChange(value) async {
    setState(() {
      districSeleted = value as int;
      finding = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    items.shuffle(Random());
    setState(() {
      finding = false;
      items = items;
    });
  }

  void _onMenuStateChange(isOpen) {
    setState(() => isDistrictOpend = isOpen);

    if (isOpen) {
      _animationController.forward(); // Bắt đầu animation
    } else {
      _animationController.reverse(); // Kết thúc animation
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const SimpleAppHeader('Độc lạ'),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));

          items.shuffle(Random());
          setState(() {
            items = items;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Địa điểm',
                style: AppStyle.textHeading3,
              ),
              const SizedBox(height: 8),
              DropdownButton2(
                alignment: Alignment.topCenter,
                value: districSeleted,
                items: districts.map((h) {
                  return DropdownMenuItem(
                    value: h['id'],
                    child: Text(h['name']),
                  );
                }).toList(),
                menuItemStyleData: MenuItemStyleData(
                  selectedMenuItemBuilder: (context, child) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: child,
                    );
                  },
                ),
                onChanged: onDistrictChange,
                onMenuStateChange: _onMenuStateChange,
                isExpanded: true,
                underline: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: AppSpace.sm),
                  decoration: BoxDecoration(
                    boxShadow: const [AppStyle.boxShadowSm],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDistrictOpend
                          ? AppColor.primary
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          districSeleted == null
                              ? 'Chọn địa điểm bạn muốn tìm...'
                              : districts.firstWhere(
                                  (h) => h['id'] == districSeleted)['name'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: AppSpace.sm),
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _animation.value * 0.5 * pi,
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black38,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                buttonStyleData: const ButtonStyleData(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  elevation: 0,
                  maxHeight: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: AppSpace.xl),
              Row(
                children: [
                  Text(
                    districSeleted == null
                        ? 'Gợi tý dành cho bạn'
                        : 'Sản phẩm dành cho bạn',
                    style: AppStyle.textHeading3,
                  ),
                  const Spacer(),
                  Text(
                    districSeleted == null
                        ? ''
                        : districts.firstWhere(
                            (h) => h['id'] == districSeleted)['name'],
                  ),
                ],
              ),
              const SizedBox(height: AppSpace.md),
              finding
                  ? Container(
                      padding: const EdgeInsets.only(top: AppSpace.xxl * 2),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
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
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
