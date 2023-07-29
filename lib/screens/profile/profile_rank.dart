import 'dart:ffi';

import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/constant.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/getx/auth_state.dart';
import 'package:flora/models/user.dart';
import 'package:flora/shared/functions.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileRankScreen extends StatelessWidget {
  const ProfileRankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthState auth = Get.find();
    final User? loginUser = auth.loginUser.value;

    return Scaffold(
      appBar: const SimpleAppHeader('Thứ hạng của bạn'),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppSpace.xl,
          right: AppSpace.xl,
          top: AppSpace.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text:
                    'Thân chào ${loginUser!.fullname},\nBạn đang là thành viên thứ hạng',
                style: const TextStyle(color: AppColor.neutral),
                children: const [
                  TextSpan(
                    text: ' Kim Cương',
                    style: TextStyle(
                        color: AppColor.primary, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            const SizedBox(height: AppSpace.xl),
            Container(
              padding: const EdgeInsets.all(AppSpace.md),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [AppStyle.boxShadowSm],
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppConstant.borderRadiusLg))),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Số tiền bạn đã tiêu:'),
                      Text(
                        Fs.vndFormat(
                          auth.rankedMoney.value,
                          options: {'symbol': 'VNĐ'},
                        ),
                        style: AppStyle.textHeading2.copyWith(
                          color: AppColor.primary,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    Asset.rankedMoney,
                    width: 50,
                  )
                ],
              ),
            ),
            const SizedBox(height: AppSpace.xl),
            RichText(
              text: const TextSpan(
                  style: TextStyle(color: AppColor.neutral),
                  children: [
                    TextSpan(
                      text:
                          'Cùng khởi động chu kỳ mới!\nChúc mừng bạn đã đạt hạng',
                    ),
                    TextSpan(
                      text: ' Kim cương ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(text: 'trong chu kỳ 1 năm 2023. Bạn đã mua'),
                    TextSpan(
                      text: ' 30 ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(text: 'đơn hàng từ 01.07.2023 đến 31.12.2023.')
                  ]),
            ),
            const SizedBox(height: AppSpace.xl),
            const Row(
              children: [
                IconWidget(
                  icon: Asset.iconStar,
                  label: 'Số xư nhận',
                  value: '50.000',
                ),
                Spacer(),
                IconWidget(
                  icon: Asset.iconDiscount,
                  label: 'Số xư nhận',
                  value: '900.000',
                ),
                Spacer(),
                IconWidget(
                  icon: Asset.iconCoupon,
                  label: 'Số xư nhận',
                  value: '12 đã dùng',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final String icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Image.asset(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppSpace.xs),
        Text(label),
        Text(value, style: AppStyle.textLabel)
      ],
    );
  }
}
