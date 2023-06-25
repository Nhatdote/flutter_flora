import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/style.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String? messsage;
  final String? image;

  const ErrorScreen({
    super.key,
    this.messsage,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' '),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: AppColor.neutral,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              image ?? Asset.errorUfo,
              height: 200,
            ),
            const SizedBox(height: 50),
            Text(
              messsage ?? 'Page not found!',
              style: AppStyle.title.copyWith(
                color: AppColor.neutral70,
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
