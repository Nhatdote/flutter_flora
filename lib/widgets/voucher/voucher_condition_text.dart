import 'package:flora/models/voucher_model.dart';
import 'package:flora/widgets/voucher/voucher_condition_popup.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../constans/color.dart';

class VoucherConditionText extends StatelessWidget {
  const VoucherConditionText(this.voucher, {super.key});

  final VoucherModel voucher;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showMaterialModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          context: context,
          builder: (BuildContext context) {
            return VoucherConditionPopup(voucher);
          },
        );
      },
      child: const Text(
        'Điều kiện',
        style: TextStyle(
          fontSize: 10,
          color: AppColor.primary,
        ),
      ),
    );
  }
}
