import 'package:flora/constans/color.dart';
import 'package:flora/constans/constant.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/widgets/button/button_constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool disable;
  final bool loading;
  final String size;
  final String type;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.disable = false,
    this.loading = false,
    this.size = 'large',
    this.type = btnTypeFilled,
  });

  @override
  Widget build(BuildContext context) {
    double btnHeight;
    double loadingSize;
    double loadingWidth;
    double fontSize;
    BoxDecoration decoration = const BoxDecoration();
    Color textColor = Colors.white;

    switch (size) {
      case 'small':
        btnHeight = 24;
        loadingSize = 12;
        loadingWidth = 1;
        fontSize = AppStyle.fontSizeSm;
        break;
      case 'medium':
        btnHeight = 34;
        loadingSize = 16;
        loadingWidth = 2;
        fontSize = AppStyle.fontSize;
        break;
      default:
        btnHeight = AppConstant.btnHeight;
        loadingSize = 22;
        loadingWidth = 2;
        fontSize = AppStyle.fontSizeLg;
    }

    switch (type) {
      case btnTypeOutlined:
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          border: Border.all(
            color: disable ? AppColor.neutral10 : AppColor.primary,
          ),
        );

        textColor = disable ? AppColor.neutral40 : AppColor.primary;

        break;
      case btnTypeLight:
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColor.primary20,
          border: Border.all(
            color: disable ? AppColor.neutral10 : AppColor.primary20,
          ),
        );

        textColor = disable ? AppColor.neutral40 : AppColor.primary;

        break;
      default:
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: disable ? AppColor.neutral10 : AppColor.primary,
        );

        textColor = disable ? AppColor.neutral40 : Colors.white;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (disable || loading) ? null : onTap,
        child: Ink(
          decoration: decoration,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: btnHeight,
            child: loading
                ? SizedBox(
                    width: loadingSize,
                    height: loadingSize,
                    child: CircularProgressIndicator(
                      color: textColor,
                      strokeWidth: loadingWidth,
                    ))
                : Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize,
                      height: 1.2,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
