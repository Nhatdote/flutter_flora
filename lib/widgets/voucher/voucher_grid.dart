import 'package:flora/constans/color.dart';
import 'package:flora/constans/constant.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/models/voucher_model.dart';
import 'package:flora/widgets/voucher/voucher_btn.dart';
import 'package:flora/widgets/voucher/voucher_condition_popup.dart';
import 'package:flora/widgets/voucher/voucher_condition_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class VoucherGrid extends StatelessWidget {
  const VoucherGrid(this.voucher, {super.key});

  final VoucherModel voucher;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [AppStyle.boxShadowSm],
        borderRadius: BorderRadius.circular(AppConstant.borderRadiusLg),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(AppSpace.xs),
      height: 100,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                ),
                child: Image.asset(
                  voucher.image,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              VoucherConditionText(voucher)
            ],
          ),
          const SizedBox(width: AppSpace.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voucher.title,
                  style: AppStyle.textLabel.copyWith(
                    color: AppColor.primary,
                  ),
                ),
                Text(
                  voucher.desc ?? '',
                  style: AppStyle.textHint,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  width: 60,
                  child: LinearProgressIndicator(
                    value: voucher.used / voucher.total,
                    backgroundColor: AppColor.accent20,
                    color: AppColor.accent50,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 78,
                  child: VoucherBtn(voucher),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
