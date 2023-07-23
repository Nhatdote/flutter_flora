import 'package:flora/constans/color.dart';
import 'package:flora/constans/constant.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/models/voucher_model.dart';
import 'package:flora/widgets/voucher/voucher_btn.dart';
import 'package:flora/widgets/voucher/voucher_condition_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VoucherList extends StatelessWidget {
  const VoucherList(this.voucher, {super.key});

  final VoucherModel voucher;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [AppStyle.boxShadowSm],
        borderRadius: BorderRadius.circular(AppConstant.borderRadiusLg),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.md,
        vertical: AppSpace.sm,
      ),
      height: 90,
      child: Row(
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
          const SizedBox(width: AppSpace.md),
          Column(
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
              const Spacer(),
              Text(
                voucher.expiredAt != null
                    ? 'HSD: ${DateFormat('dd/MM/yyyy').format(voucher.expiredAt!)}'
                    : '',
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              SizedBox(
                width: 94,
                child: VoucherBtn(
                  voucher,
                  size: 'medium',
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: AppSpace.xs),
                width: 84,
                child: LinearProgressIndicator(
                  value: voucher.used / voucher.total,
                  backgroundColor: AppColor.accent20,
                  color: AppColor.accent50,
                ),
              ),
              const Spacer(),
              VoucherConditionText(voucher),
            ],
          ),
        ],
      ),
    );
  }
}
