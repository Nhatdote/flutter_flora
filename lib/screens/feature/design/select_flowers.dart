import 'package:flora/constans/color.dart';
import 'package:flora/constans/constan.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/routes.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/button.dart';
import 'package:flora/widgets/card/product_card.dart';
import 'package:flutter/material.dart';

class DesignSelectFlowersScreen extends StatefulWidget {
  final int shopId;

  const DesignSelectFlowersScreen(
    this.shopId, {
    super.key,
  });

  @override
  State<DesignSelectFlowersScreen> createState() =>
      _DesignSelectFlowersScreenState();
}

class _DesignSelectFlowersScreenState extends State<DesignSelectFlowersScreen> {
  bool btnDisalbed = true;
  List<ProductModel> items = [];
  Set<int> selectedIds = {};

  @override
  void initState() {
    super.initState();
    setState(() {
      items = DB.getFlowers().map((h) {
        return ProductModel(
          id: h.id,
          image: h.image,
          name: h.name,
          price: h.price,
          star: h.star,
          sold: h.sold,
          discount: null,
        );
      }).toList();
    });
  }

  onSelected(int id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }

    setState(() {
      selectedIds = selectedIds;
      btnDisalbed = selectedIds.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const SimpleAppHeader('Thiết kế'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: AppSpace.xl,
              right: AppSpace.xl,
              bottom: AppSpace.xl,
            ),
            child: Text(
              'Chọn hoa mà bạn muốn thiết kế',
              style: TextStyle(fontWeight: FontWeight.w600),
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
                              fillColor:
                                  MaterialStateColor.resolveWith((states) {
                                return AppColor.primary;
                              }),
                              value: isChecked,
                              onChanged: null,
                            ),
                          ),
                        )
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
              disable: btnDisalbed,
              onTab: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.designSelectWrap,
                  arguments: {
                    'ids': selectedIds.toList(),
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
