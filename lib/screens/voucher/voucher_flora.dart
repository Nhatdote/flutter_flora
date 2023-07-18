import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/db.dart';
import 'package:flora/models/voucher_model.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/voucher/voucher_list.dart';
import 'package:flutter/material.dart';

class VoucherFloraScreen extends StatefulWidget {
  const VoucherFloraScreen({super.key});

  @override
  State<VoucherFloraScreen> createState() => _VoucherFloraScreenState();
}

class _VoucherFloraScreenState extends State<VoucherFloraScreen> {
  late List<VoucherModel> vouchers;

  @override
  void initState() {
    super.initState();
    setState(() {
      vouchers = DB.vouchers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const SimpleAppHeader('Voucher từ Flora'),
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
