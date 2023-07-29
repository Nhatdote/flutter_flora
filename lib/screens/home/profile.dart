import 'dart:ui';
import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/constant.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/getx/auth_state.dart';
import 'package:flora/routes.dart';
import 'package:flora/shared/functions.dart';
import 'package:flora/widgets/dot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final AuthState auth = Get.find();
  final double headerHeight = 300;
  final double borderRadius = 24.0;

  final List<dynamic> items = [
    {
      'icon': Asset.iconUserSolid,
      'label': 'Thông tin đăng nhập',
      'route': AppRoute.profileInfo,
    },
    {
      'icon': Asset.iconHomeSolid,
      'label': 'Yêu thích',
      'route': null,
    },
    {
      'icon': Asset.iconCouponSolid,
      'label': 'Ví voucher',
      'route': null,
    },
    {
      'icon': Asset.iconUserSolid,
      'label': 'Cài đặt',
      'route': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(borderRadius),
                    bottomRight: Radius.circular(borderRadius),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                width: double.infinity,
                height: headerHeight,
                child: Image.asset(
                  'assets/images/avatar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: headerHeight,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.4),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
              ),
            ),
            Container(
              height: headerHeight + 30,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 30,
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    width: 95,
                    height: 95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'assets/images/avatar.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: AppSpace.md),
                  Text(
                    auth.loginUser.value!.fullname,
                    style: AppStyle.textHeading2.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: AppSpace.xl,
              child: Container(
                width: MediaQuery.of(context).size.width - AppSpace.xl * 2,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppConstant.borderRadius),
                  ),
                  boxShadow: [AppStyle.boxShadow],
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpace.xl,
                  horizontal: AppSpace.md,
                ),
                child: Row(
                  children: [
                    Image.asset(Asset.coin),
                    const SizedBox(width: AppSpace.xs),
                    Text(
                      Fs.vndFormat(
                        auth.voucherCoint.value,
                        options: {'symbol': 'Xu'},
                      ),
                      style: AppStyle.textHeading3.copyWith(
                        color: AppColor.primary,
                      ),
                    ),
                    const Spacer(),
                    const Dot(),
                    const Spacer(),
                    Image.asset(Asset.diamond),
                    const SizedBox(width: AppSpace.xs),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoute.profileRank),
                      child: Text(
                        'Hạng Kim Cương',
                        style: AppStyle.textHeading3.copyWith(
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: items
                  .map((h) => MenuWidget(
                        icon: h['icon'],
                        label: h['label'],
                        route: h['route'],
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget(
      {super.key, required this.icon, required this.label, this.route});

  final String icon;
  final String label;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpace.xl,
        right: AppSpace.xl,
        top: AppSpace.xl,
      ),
      child: GestureDetector(
        onTap:
            route != null ? () => Navigator.pushNamed(context, route!) : null,
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
      ),
    );
  }
}
