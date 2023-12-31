import 'dart:async';
import 'dart:math';

import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/routes.dart';
import 'package:flora/shared/toast.dart';
import 'package:flora/widgets/button/app_button.dart';
import 'package:flutter/material.dart';

class RegisterOtpScreen extends StatefulWidget {
  final String phone;

  const RegisterOtpScreen({
    super.key,
    required this.phone,
  });

  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  bool btnDisabled = true;
  bool btnLoading = false;
  String? filledOtp;
  late String otp;

  @override
  void initState() {
    super.initState();

    makeOtp();
  }

  makeOtp() {
    Random random = Random();
    String newOtp = '';

    for (int i = 0; i < 4; i++) {
      newOtp += random.nextInt(9).toString();
    }

    Toast.show(
      '[DEV] Mã OTP của bạn là $newOtp',
      type: Toast.toastSuccess,
      hidePrevSnackbar: false,
    );

    setState(() {
      otp = newOtp;
    });
  }

  void onFilledOtp(String value) {
    setState(() {
      btnDisabled = value.length != 4;
      filledOtp = value.length == 4 ? value : null;
    });
  }

  onNext(thisContext) async {
    setState(() {
      btnLoading = true;
    });

    FocusScope.of(context).unfocus();

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      btnLoading = false;
    });

    // checking API
    if (filledOtp == null || filledOtp != otp) {
      Toast.show('OTP không chính xác', type: Toast.toastError);
      return;
    }

    Navigator.pushNamed(
      thisContext,
      AppRoute.registerForm,
      arguments: {
        'phone': widget.phone,
      },
    );
  }

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
            Padding(
              padding: const EdgeInsets.only(bottom: 48, top: 28),
              child: Text(
                'Nhập mã xác minh vừa được gửi vào\nsố điện thoại ${widget.phone}.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColor.neutral70,
                  fontSize: 16,
                ),
              ),
            ),
            OtpWidget(onFilledOtp: onFilledOtp),
            ResendOtpWidget(makeOtp: makeOtp),
            AppButton(
              disable: btnDisabled,
              loading: btnLoading,
              label: 'Tiếp tục',
              onTap: () => onNext(context),
            )
          ],
        ),
      ),
    );
  }
}

class ResendOtpWidget extends StatefulWidget {
  final VoidCallback makeOtp;

  const ResendOtpWidget({
    super.key,
    required this.makeOtp,
  });

  @override
  State<ResendOtpWidget> createState() => _ResendOtpWidgetState();
}

class _ResendOtpWidgetState extends State<ResendOtpWidget> {
  late int seconds;

  @override
  void initState() {
    super.initState();
    countdown();
  }

  void countdown() {
    setState(() {
      seconds = 10;
    });

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        setState(() {
          seconds--;
        });
      }

      if (seconds == 0) {
        timer.cancel();
      }
    });
  }

  void resend() {
    if (seconds > 0) {
      return;
    }

    widget.makeOtp();

    countdown();

    // API
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 44, bottom: AppSpace.xxl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Không nhận được mã OTP?'),
          const SizedBox(width: AppSpace.xs),
          InkWell(
            onTap: seconds == 0 ? resend : null,
            child: Text(
              'Gửi lại ${seconds > 0 ? '(${seconds}s)' : ''}',
              style: const TextStyle(
                color: AppColor.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OtpWidget extends StatefulWidget {
  final void Function(String) onFilledOtp;

  const OtpWidget({
    super.key,
    required this.onFilledOtp,
  });

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  late List<FocusNode> focusNodes;
  late List<TextEditingController> inputControllers;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(4, (index) => FocusNode());
    inputControllers = List.generate(4, (index) => TextEditingController());

    focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    for (int i = 0; i < 4; i++) {
      focusNodes[i].dispose();
      inputControllers[i].dispose();
    }

    super.dispose();
  }

  void onOtpChange(value, int index) {
    if (value == '') {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    } else {
      if (value.length > 1) {
        inputControllers[index].text = value[value.length - 1];
      }

      if (index < 3) {
        focusNodes[index].unfocus();
        focusNodes[index + 1].requestFocus();
      }
    }

    isFilled();
  }

  void isFilled() {
    String filled = '';

    for (int i = 0; i < 4; i++) {
      if (inputControllers[i].text != '') {
        filled += inputControllers[i].text;
      }
    }

    widget.onFilledOtp(filled);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpace.xs),
          width: 60,
          height: 70,
          child: TextField(
            focusNode: focusNodes[index],
            controller: inputControllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            showCursor: false,
            onChanged: (value) => onOtpChange(value, index),
            maxLength: 2,
            decoration: InputDecoration(
              counterText: ' ',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
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
      }),
    );
  }
}
