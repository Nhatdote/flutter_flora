import 'package:flora/constans/asset.dart';
import 'package:flora/constans/space.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Asset.logo, height: 70),
        const SizedBox(height: AppSpace.xl),
        Image.asset(Asset.logoText, height: 35,)
      ],
    );
  }
}