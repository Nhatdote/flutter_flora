import 'package:flora/models/voucher_model.dart';
import 'package:flora/routes.dart';
import 'package:flora/shared/toast.dart';
import 'package:flora/widgets/button/app_button.dart';
import 'package:flora/widgets/button/button_constants.dart';
import 'package:flutter/material.dart';

class VoucherBtn extends StatelessWidget {
  const VoucherBtn(this.voucher, {super.key, this.size = 'small'});

  final VoucherModel voucher;
  final String size;

  @override
  Widget build(BuildContext context) {
    void Function()? onTap;
    String label;
    String type = btnTypeFilled;

    if (voucher.used == voucher.total) {
      label = 'Đã hết';
      onTap = null;
    } else if (!voucher.hasSavedVoucher) {
      label = 'Lưu';
      onTap = () {
        Toast.showSuccess('Saved!');
      };
    } else {
      label = 'Dùng ngay';
      onTap = () => Navigator.pushNamed(context, AppRoute.other);
      type = btnTypeOutlined;
    }

    return AppButton(
      label: label,
      size: size,
      onTap: onTap,
      disable: onTap == null,
      type: type,
    );
  }
}
