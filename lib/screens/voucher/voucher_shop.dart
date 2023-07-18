import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/db.dart';
import 'package:flora/models/voucher_model.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/voucher/voucher_list.dart';
import 'package:flutter/material.dart';

class VoucherShopScreen extends StatefulWidget {
  const VoucherShopScreen({super.key});

  @override
  State<VoucherShopScreen> createState() => _VoucherShopScreenState();
}

class _VoucherShopScreenState extends State<VoucherShopScreen> {
  late List<VoucherModel> vouchers;

  @override
  void initState() {
    super.initState();
    setState(() {
      vouchers = DB.vouchers(from: fromShop);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const SimpleAppHeader('Voucher từ Shop'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => VoucherList(vouchers[index]),
          separatorBuilder: (_, __) => const SizedBox(height: AppSpace.xl),
          itemCount: vouchers.length,
        ),
      ),
    );
  }
}
