import 'package:flora/constans/color.dart';
import 'package:flora/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Flora());

class Flora extends StatelessWidget {
  const Flora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flora',
      theme: themeData,
      initialRoute: AppRoute.splash,
      routes: AppRoute.getRoutes(),
    );
  }
}

ThemeData themeData = ThemeData(
  fontFamily: 'Gilroy',
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 14, height: 1.5, color: AppColor.neutral),
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: AppColor.neutral10),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: AppColor.primary),
    ),
    filled: true,
    fillColor: Colors.white,
    focusColor: AppColor.primary20,
  ),
);
