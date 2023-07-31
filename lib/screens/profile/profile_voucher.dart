import 'package:flora/constans/space.dart';
import 'package:flora/db.dart';
import 'package:flora/models/voucher_model.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/voucher/voucher_list.dart';
import 'package:flutter/material.dart';

class ProfileVoucherScreen extends StatefulWidget {
  const ProfileVoucherScreen({super.key});

  @override
  State<ProfileVoucherScreen> createState() => _ProfileVoucherScreenState();
}

class _ProfileVoucherScreenState extends State<ProfileVoucherScreen> {
  List<VoucherModel> items =
      DB.vouchers().where((h) => h.used < h.total).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppHeader('Ví Voucher'),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          items.shuffle();
          setState(() {
            items = items;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.xl),
          child: ListView.separated(
            itemBuilder: (context, index) => VoucherList(items[index]),
            separatorBuilder: (_, __) => const SizedBox(height: AppSpace.xl),
            itemCount: items.length,
          ),
        ),
      ),
    );
  }
}
