import 'package:flora/constans/asset.dart';
import 'package:flora/routes.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flutter/material.dart';

import '../../constans/color.dart';
import '../../constans/constant.dart';
import '../../constans/space.dart';
import '../../constans/style.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final List<dynamic> items = [
    {
      'icon': Asset.iconShieldSolid,
      'label': 'Bảo mật',
      'route': AppRoute.profileSecure,
    },
    {
      'icon': Asset.iconBellSolid,
      'label': 'Thông báo',
      'route': AppRoute.profileNotification,
    },
    {
      'icon': Asset.iconGlobalSolid,
      'label': 'Ngôn ngữ',
      'route': AppRoute.profileLanguage,
    },
    {
      'icon': Asset.iconCreditCardSolid,
      'label': 'Thanh toán',
      'route': AppRoute.profilePayment,
    },
    {
      'icon': Asset.iconQuestionSolid,
      'label': 'Câu hỏi và hỗ trợ',
      'route': AppRoute.faq,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppHeader('Cài đặt'),
      body: Padding(
        padding: const EdgeInsets.all(AppSpace.xl),
        child: ListView.separated(
          itemBuilder: (context, index) {
            final dynamic h = items[index];
            return MenuWidget(
              icon: h['icon'],
              label: h['label'],
              route: h['route'],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: AppSpace.xl),
          itemCount: items.length,
        ),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.icon,
    required this.label,
    this.route,
  });

  final String icon;
  final String label;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: route != null ? () => Navigator.pushNamed(context, route!) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpace.xl,
          horizontal: AppSpace.sm,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [AppStyle.boxShadow],
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstant.borderRadius),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              color: AppColor.primary,
            ),
            const SizedBox(width: AppSpace.sm),
            Expanded(
              child: Text(
                label,
                style: AppStyle.textLabel,
              ),
            ),
            const Icon(Icons.chevron_right_rounded)
          ],
        ),
      ),
    );
  }
}
