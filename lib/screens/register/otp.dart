import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/widgets/button.dart';
import 'package:flutter/material.dart';

class RegisterOtpScreen extends StatefulWidget {
  const RegisterOtpScreen({super.key});

  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: AppColor.neutral,
        ),
        title: const Text(
          'Xác nhận số điện thoại',
          style: TextStyle(
            color: AppColor.neutral,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.xxl),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 48, top: 28),
              child: Text(
                'Nhập mã xác minh vừa được gửi vào\nsố điện thoại đăng ký.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.neutral70,
                  fontSize: 16,
                ),
              ),
            ),
            const OtpWidget(),
            const Padding(
              padding: EdgeInsets.only(top: 44, bottom: AppSpace.xxl),
              child: ResendOtpWidget(),
            ),
            AppButton(
              label: 'Tiếp tục',
              onTab: () {},
            )
          ],
        ),
      ),
    );
  }
}

class ResendOtpWidget extends StatefulWidget {
  const ResendOtpWidget({super.key});

  @override
  State<ResendOtpWidget> createState() => _ResendOtpWidgetState();
}

class _ResendOtpWidgetState extends State<ResendOtpWidget> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Không nhận được mã OTP?'),
        SizedBox(width: AppSpace.xs),
        Text(
          'Gửi lại (55s)',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class OtpWidget extends StatefulWidget {
  const OtpWidget({super.key});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OtpWidgetInput(),
        SizedBox(width: AppSpace.md),
        OtpWidgetInput(),
        SizedBox(width: AppSpace.md),
        OtpWidgetInput(),
        SizedBox(width: AppSpace.md),
        OtpWidgetInput(),
      ],
    );
  }
}

class OtpWidgetInput extends StatefulWidget {
  final String? value;
  const OtpWidgetInput({super.key, this.value});

  @override
  State<OtpWidgetInput> createState() => _OtpWidgetInputState();
}

class _OtpWidgetInputState extends State<OtpWidgetInput> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 63,
      height: 52,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColor.neutral10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColor.primary),
          ),
        ),
      ),
    );
  }
}
