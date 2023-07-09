import 'dart:math';

import 'package:flora/constans/color.dart';
import 'package:flora/db.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/card/product_card.dart';
import 'package:flutter/material.dart';
import '../../constans/constan.dart';
import '../../constans/space.dart';
import '../../constans/style.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({super.key});

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  List<ProductModel> items = [];
  final ScrollController _controller = ScrollController();
  bool isLoading = false;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));

    items.shuffle(Random());
    setState(() {
      items = items;
    });
  }

  Future<void> _onLoadmore() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      items = items + DB.getFlowers();
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    items = DB.getFlowers();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        _onLoadmore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const SimpleAppHeader('Khác'),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: AppSpace.xl,
                  right: AppSpace.xl,
                  bottom: 12,
                ),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  boxShadow: const [AppStyle.boxShadowSm],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Image.asset(
                  'assets/images/layout/other.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                width: 42,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.primary,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSpace.sm,
                  horizontal: 50,
                ),
                child: Text(
                  'Các sản phẩm có ưu đãi,\nCó deal ngon, đặt hàng liền.',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
              Center(
                child: Opacity(
                  opacity: isLoading ? 0 : 1,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.topCenter,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
