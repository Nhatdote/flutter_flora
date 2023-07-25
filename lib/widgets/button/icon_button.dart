import 'package:flora/constans/color.dart';
import 'package:flora/widgets/button/button_constants.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton(
    this.child, {
    super.key,
    this.size = 36,
    this.type = btnTypeText,
    this.onTap,
  });

  final Widget child;
  final double? size;
  final String? type;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        splashColor: AppColor.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.background,
          ),
          child: Container(
            alignment: Alignment.center,
            width: size,
            height: size,
            child: child,
          ),
        ),
      ),
    );
  }
}
