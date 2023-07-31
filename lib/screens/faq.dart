import 'package:flora/constans/style.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SimpleAppHeader('FAQ'),
      body: Center(
        child: Text(
          'FAQ',
          style: AppStyle.textHeading2,
        ),
      ),
    );
  }
}
