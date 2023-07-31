import 'dart:ui';
import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/constant.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/getx/auth_state.dart';
import 'package:flora/routes.dart';
import 'package:flora/shared/functions.dart';
import 'package:flora/widgets/button/app_button.dart';
import 'package:flora/widgets/button/button_constants.dart';
import 'package:flora/widgets/dot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final AuthState auth = Get.find();
  final double headerHeight = 300;
  final double borderRadius = 24.0;

  void handleLogout() {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpace.xl,
                  vertical: AppSpace.sm,
                ),
                child: Text(
                  'Đăng xuất',
                  style: AppStyle.textHeading2.copyWith(
                    color: AppColor.primary,
                  ),
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(AppSpace.xl),
                child: Text(
                  'Bạn thực sự muốn đăng xuất?',
                  style: AppStyle.textHeading3,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppSpace.xl,
                  right: AppSpace.xl,
                  bottom: AppSpace.sm + MediaQuery.of(context).padding.bottom,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Thoát',
                        onTap: () => Navigator.pop(context),
                        type: btnTypeLight,
                      ),
                    ),
                    const SizedBox(width: AppSpace.xl),
                    Expanded(
                      child: AppButton(
                        label: 'Đăng xuất',
                        onTap: () {
                          auth.setLoginUser(null);
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoute.login, (route) => false);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> items = [
      {
        'icon': Asset.iconUserSolid,
        'label': 'Thông tin đăng nhập',
        'route': AppRoute.profileInfo,
      },
      {
        'icon': Asset.iconHomeSolid,
        'label': 'Yêu thích',
        'route': AppRoute.profileFavorite,
      },
      {
        'icon': Asset.iconCouponSolid,
        'label': 'Ví voucher',
        'route': AppRoute.profileVoucher,
      },
      {
        'icon': Asset.iconUserSolid,
        'label': 'Cài đặt',
        'route': AppRoute.profileSetting,
      },
      {
        'icon': Asset.iconLogin,
        'label': 'Đăng xuất',
        'route': null,
        'onTap': handleLogout
      },
    ];

    return Column(
      children: [
        Stack(
          children: [
            Container(
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
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
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
                      onTap: h['onTap']))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.icon,
    required this.label,
    this.route,
    this.onTap,
  });

  final String icon;
  final String label;
  final String? route;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpace.xl,
        right: AppSpace.xl,
        top: AppSpace.xl,
      ),
      child: GestureDetector(
        onTap: () {
          if (route != null) {
            Navigator.pushNamed(context, route!);
          } else if (onTap != null) {
            onTap!();
          }
        },
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
