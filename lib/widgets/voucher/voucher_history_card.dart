import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/models/voucher_history_model.dart';
import 'package:flora/shared/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VoucherHistoryCard extends StatelessWidget {
  const VoucherHistoryCard(this.voucherHistory, {super.key});

  final VoucherHistoryModel voucherHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: const [AppStyle.boxShadow],
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.md,
          vertical: AppSpace.sm,
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.only(right: AppSpace.xs),
              child: Image.asset(
                voucherHistory.productImage,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucherHistory.productName,
                    style: AppStyle.textLabel,
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(voucherHistory.date),
                    style: const TextStyle(
                      color: AppColor.neutral40,
                    ),
                  )
                ],
              ),
            ),
            Text(
              '${voucherHistory.type == VoucherHistoryType.voucherHistoryIn ? '+' : '-'}${Fs.vndFormat(voucherHistory.amount, options: {
                    'symbol': ''
                  })}',
              style:
                  AppStyle.textHeading3.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }
}
