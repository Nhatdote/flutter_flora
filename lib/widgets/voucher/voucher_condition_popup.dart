import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/models/voucher_model.dart';
import 'package:flora/widgets/button/app_button.dart';
import 'package:flora/widgets/button/button_constants.dart';
import 'package:flora/widgets/voucher/voucher_btn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VoucherConditionPopup extends StatelessWidget {
  const VoucherConditionPopup(this.voucher, {super.key});

  final VoucherModel voucher;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        top: AppSpace.sm,
        left: AppSpace.xl,
        right: AppSpace.xl,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        children: [
          const Text(
            'Điều kiện voucher',
            style: AppStyle.textHeading3,
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  LineWidget(
                    title: 'Hạn sử dụng',
                    value: voucher.expiredAt != null
                        ? DateFormat('dd/MM/yyyy').format(voucher.expiredAt!)
                        : 'Không có',
                  ),
                  LineWidget(
                      title: 'Phương thức thanh toán',
                      value: VoucherModel.payMethodLabel(voucher.payMethod)),
                  LineWidget(
                    title: 'Gía trị đơn hàng tối thiểu',
                    value: voucher.minPrice ?? 'Không có',
                  ),
                  LineWidget(
                    title: 'Điều kiện chi tiết',
                    value: '${voucher.content}',
                    landspace: true,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSpace.xs),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Xong',
                    type: btnTypeOutlined,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: AppSpace.xs),
                Expanded(
                  child: VoucherBtn(
                    voucher,
                    size: 'large',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LineWidget extends StatelessWidget {
  const LineWidget({
    super.key,
    required this.title,
    required this.value,
    this.landspace = false,
  });

  final String title;
  final dynamic value;
  final bool landspace;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.xs),
      child: !landspace
          ? Row(
              children: [
                Text(title, style: AppStyle.textHint),
                const Spacer(),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpace.xs),
                  child: Text(title, style: AppStyle.textHint),
                ),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
    );
  }
}
