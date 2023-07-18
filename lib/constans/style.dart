import 'package:flora/constans/color.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static const double fontSizeSm = 12;
  static const double fontSize = 14;
  static const double fontSizeLg = 16;

  static const TextStyle title = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 28,
    color: AppColor.neutral,
  );

  static const TextStyle textLabel = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColor.neutral,
  );

  static const TextStyle textHint = TextStyle(
    fontSize: 12,
    color: AppColor.neutral40,
  );

  static const TextStyle textHeading2 = TextStyle(
    fontSize: 22,
    color: AppColor.neutral,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle textHeading3 = TextStyle(
    fontSize: 18,
    color: AppColor.neutral,
    fontWeight: FontWeight.w600,
  );

  static const BoxShadow boxShadow = BoxShadow(
    color: Colors.black12,
    offset: Offset(1, 1),
    blurRadius: 5,
  );

  static const BoxShadow boxShadowSm = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.04),
    offset: Offset(1, 1),
    blurRadius: 9,
    spreadRadius: 0,
  );
}
