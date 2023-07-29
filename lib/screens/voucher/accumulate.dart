import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/constant.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/getx/auth_state.dart';
import 'package:flora/models/voucher_history_model.dart';
import 'package:flora/shared/functions.dart';
import 'package:flora/shared/toast.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/button/app_button.dart';
import 'package:flora/widgets/button/button_constants.dart';
import 'package:flora/widgets/button/icon_button.dart';
import 'package:flora/widgets/voucher/voucher_history_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccumulateScreen extends StatefulWidget {
  const AccumulateScreen({super.key});

  @override
  State<AccumulateScreen> createState() => _AccumulateScreenState();
}

class _AccumulateScreenState extends State<AccumulateScreen> {
  int currentIndex = 1;
  late List<VoucherHistoryModel> items;
  late List<VoucherHistoryModel> outs;
  late List<VoucherHistoryModel> ins;
  final AuthState auth = Get.find();

  @override
  void initState() {
    super.initState();

    setState(() {
      items = DB.voucherHistories;
      outs = items
          .where((h) => h.type == VoucherHistoryType.voucherHistoryOut)
          .toList();
      ins = items
          .where((h) => h.type == VoucherHistoryType.voucherHistoryIn)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppHeader(
        'Điểm tích luỹ',
        actions: [
          AppIconButton(
            Image.asset(Asset.iconBell),
            size: AppConstant.appBarHeight,
            onTap: () {
              Toast.show('OK!');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                boxShadow: [AppStyle.boxShadow],
                borderRadius: BorderRadius.all(
                  Radius.circular(AppConstant.borderRadiusLg),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: AppSpace.md,
                horizontal: AppSpace.xl,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpace.sm),
                    child: CircleAvatar(
                      backgroundColor: AppColor.primary,
                      radius: 30,
                      child: Text(
                        Fs.getAvatarLetter(auth.loginUser.value!.fullname),
                        style:
                            const TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              Fs.vndFormat(
                                auth.voucherCoint.value,
                                options: {'symbol': ''},
                              ),
                              style: AppStyle.textHeading2,
                            ),
                            Image.asset(Asset.coin),
                          ],
                        ),
                        const Text('Hết hạn vào 30/04/2023',
                            style: AppStyle.textHint)
                      ],
                    ),
                  ),
                  const SizedBox(
                      width: 120,
                      child: AppButton(
                        label: 'Dùng ngay',
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.xxl),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Lịch sử',
                      type: currentIndex == 0 ? btnTypeFilled : btnTypeOutlined,
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpace.sm),
                  Expanded(
                    child: AppButton(
                      label: 'Đã nhận',
                      type: currentIndex == 1 ? btnTypeFilled : btnTypeOutlined,
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpace.sm),
                  Expanded(
                    child: AppButton(
                      label: 'Đã dùng',
                      type: currentIndex == 2 ? btnTypeFilled : btnTypeOutlined,
                      onTap: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: currentIndex,
                children: [
                  ListView.separated(
                    itemBuilder: (context, index) =>
                        VoucherHistoryCard(items[index]),
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpace.xl),
                    itemCount: items.length,
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) =>
                        VoucherHistoryCard(ins[index]),
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpace.xl),
                    itemCount: ins.length,
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) =>
                        VoucherHistoryCard(outs[index]),
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpace.xl),
                    itemCount: outs.length,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
