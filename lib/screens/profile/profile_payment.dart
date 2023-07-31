import 'package:flora/constans/style.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flutter/material.dart';

class ProfilePaymantScreen extends StatefulWidget {
  const ProfilePaymantScreen({super.key});

  @override
  State<ProfilePaymantScreen> createState() => _ProfilePaymantScreenState();
}

class _ProfilePaymantScreenState extends State<ProfilePaymantScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SimpleAppHeader('Payment'),
      body: Center(
        child: Text(
          'Payment',
          style: AppStyle.textHeading2,
        ),
      ),
    );
  }
}
