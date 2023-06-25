import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/widgets/button.dart';
import 'package:flora/widgets/logo.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class RegisterSuccessScreen extends StatefulWidget {
  const RegisterSuccessScreen({super.key});

  @override
  State<RegisterSuccessScreen> createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen> {
  Widget body = const SuccessWidget();

  @override
  void initState() {
    super.initState();

    changeState();
  }

  void changeState() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      body = const StartWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
    );
  }
}

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 120,
            color: Colors.green,
          ),
          SizedBox(height: 100),
          Text(
            'Đăng ký thành công!',
            style: AppStyle.textHeading2,
          ),
        ],
      ),
    );
  }
}

class StartWidget extends StatelessWidget {
  const StartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.xl),
        child: Column(
          children: [
            const Spacer(),
            const Logo(),
            const SizedBox(height: 35),
            const Text(
              'Chào mừng bạn đến với Flora',
              style: AppStyle.textHeading2,
            ),
            const Spacer(),
            AppButton(
              label: 'Bắt đầu',
              onTab: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.login,
                (route) => false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
