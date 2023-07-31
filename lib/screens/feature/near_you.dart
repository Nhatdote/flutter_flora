import 'package:flora/constans/color.dart';
import 'package:flora/constans/constant.dart';
import 'package:flora/db.dart';
import 'package:flora/models/shop_model.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/card/shop_card.dart';
import 'package:flutter/material.dart';
import '../../constans/space.dart';

class NearYouScreen extends StatefulWidget {
  const NearYouScreen({super.key});

  @override
  State<NearYouScreen> createState() => _NearYouScreenState();
}

class _NearYouScreenState extends State<NearYouScreen> {
  List<ShopModel> items = [];

  @override
  void initState() {
    super.initState();
    items = DB.shopList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const SimpleAppHeader('Gần bạn'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpace.md,
            mainAxisSpacing: AppSpace.md,
            childAspectRatio: AppConstant.shopRatio,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ShopCard(
              shop: items[index],
            );
          },
        ),
      ),
    );
  }
}
