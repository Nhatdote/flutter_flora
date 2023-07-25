import 'package:flora/constans/asset.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/models/product_model.dart';
import 'package:flora/models/voucher_model.dart';
import 'package:flora/routes.dart';
import 'package:flora/screens/voucher/accumulate.dart';
import 'package:flora/shared/toast.dart';
import 'package:flora/widgets/button/icon_button.dart';
import 'package:flora/widgets/card/product_card.dart';
import 'package:flora/widgets/input/search.dart';
import 'package:flora/widgets/voucher/voucher_grid.dart';
import 'package:flutter/material.dart';

class EndowScreen extends StatefulWidget {
  const EndowScreen({super.key});

  @override
  State<EndowScreen> createState() => _EndowScreenState();
}

class _EndowScreenState extends State<EndowScreen> {
  late List<VoucherModel> floraVouchers;
  late List<VoucherModel> shopVouchers;
  late List<ProductModel> suggestItems;

  @override
  void initState() {
    super.initState();

    load();
  }

  Future<void> load() async {
    setState(() {
      floraVouchers = DB.vouchers().sublist(0, 2);
      shopVouchers = DB.vouchers(from: fromShop).sublist(0, 2);
      suggestItems = DB.getFlowers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        displacement: 140.0,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          load();
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.xl,
                    vertical: AppSpace.sm,
                  ),
                  child: const Text(
                    'Ưu đãi',
                    textAlign: TextAlign.center,
                    style: AppStyle.textHeading2,
                  ),
                ),
                Positioned(
                  top: AppSpace.sm,
                  right: AppSpace.xl,
                  child: Row(
                    children: [
                      AppIconButton(
                        Image.asset(Asset.iconStar),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AccumulateScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      AppIconButton(
                        Image.asset(Asset.iconBell),
                        onTap: () {
                          Toast.show('OK!');
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: AppSpace.xl,
                right: AppSpace.xl,
                top: AppSpace.sm,
              ),
              child: AppInputSearch(
                placeholder: "Tìm kiếm voucher...",
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
                  child: Column(
                    children: [
                      shopVouchers.isEmpty
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(top: AppSpace.xl),
                              child: SectionGrid(
                                title: 'Voucher từ Shop',
                                route: AppRoute.voucherShop,
                                items: shopVouchers,
                                mainAxisExtent: 100,
                                builder: (dynamic item) => VoucherGrid(item),
                              ),
                            ),
                      floraVouchers.isEmpty
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(top: AppSpace.xl),
                              child: SectionGrid(
                                title: 'Voucher từ Flora',
                                route: AppRoute.voucherFlora,
                                items: floraVouchers,
                                mainAxisExtent: 100,
                                builder: (dynamic item) => VoucherGrid(item),
                              ),
                            ),
                      const SizedBox(height: AppSpace.xl),
                      SectionGrid(
                        title: 'Dành cho bạn',
                        route: AppRoute.other,
                        items: suggestItems,
                        mainAxisExtent: 265,
                        builder: (dynamic item) => ProductCard(product: item),
                      ),
                      const SizedBox(height: AppSpace.xl + AppSpace.xl),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SectionGrid extends StatelessWidget {
  const SectionGrid({
    super.key,
    required this.title,
    required this.route,
    required this.items,
    required this.builder,
    required this.mainAxisExtent,
  });

  final String title;
  final dynamic route;
  final double mainAxisExtent;
  final List<dynamic> items;
  final Widget Function(dynamic) builder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppStyle.textHeading3,
            ),
            const Spacer(),
            AppIconButton(
              const Icon(Icons.arrow_forward_ios_rounded),
              onTap: route != null
                  ? () => Navigator.pushNamed(context, route)
                  : null,
            )
          ],
        ),
        const SizedBox(height: AppSpace.xs),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpace.md,
            crossAxisSpacing: AppSpace.md,
            mainAxisExtent: mainAxisExtent,
          ),
          itemBuilder: (context, index) => builder(items[index]),
        )
      ],
    );
  }
}
