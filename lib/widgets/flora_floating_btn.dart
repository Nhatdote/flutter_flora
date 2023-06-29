import 'package:flora/constans/asset.dart';
import 'package:flutter/material.dart';

class FloraFloatingBtn extends StatelessWidget {
  const FloraFloatingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            left: 2,
            child: Image.asset(Asset.iconFloraCamFour),
          ),
          Positioned.fill(
            bottom: 4,
            left: 1,
            child: Image.asset(Asset.iconFloraCamLogo),
          ),
        ],
      ),
    );
  }
}
