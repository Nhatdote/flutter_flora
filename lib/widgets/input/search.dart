import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flutter/material.dart';

class AppInputSearch extends StatelessWidget {
  const AppInputSearch({
    super.key,
    this.placeholder,
  });

  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Image.asset(Asset.iconSearch),
        hintText: placeholder ?? 'Tìm kiếm...',
        isDense: true,
        hintStyle: const TextStyle(height: 1.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColor.neutral10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColor.primary),
        ),
      ),
    );
  }
}
