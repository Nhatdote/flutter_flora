import 'package:flora/getx/auth_state.dart';
import 'package:flora/widgets/input/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constans/asset.dart';
import '../constans/color.dart';
import '../constans/space.dart';
import '../constans/style.dart';

class AppPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;

  AppPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isExpanded = shrinkOffset <= 25;

    return SizedBox.expand(
      child: ExpandedHeader(isExpanded),
    );
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(covariant AppPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}

class ExpandedHeader extends StatelessWidget {
  final bool isExpanded;

  const ExpandedHeader(
    this.isExpanded, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthState auth = Get.find();

    Widget animatedText = Padding(
      padding: const EdgeInsets.only(left: AppSpace.xs),
      child: AnimatedAlign(
        alignment: !isExpanded ? Alignment.center : Alignment.topLeft,
        duration: const Duration(milliseconds: 200),
        child: AnimatedDefaultTextStyle(
          style: !isExpanded
              ? AppStyle.textHeading3.copyWith(color: Colors.white)
              : const TextStyle(color: Colors.white),
          duration: const Duration(milliseconds: 200),
          child: Text(
            'Hi, ${auth.loginUser.value!.fullname}',
            textAlign: !isExpanded ? TextAlign.center : TextAlign.left,
          ),
        ),
      ),
    );

    return Container(
      decoration: const BoxDecoration(
        color: AppColor.primary,
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              Asset.headerSmoke1,
              fit: BoxFit.cover,
              width: 100,
            ),
          ),
          !isExpanded
              ? Container()
              : Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    Asset.headerSmoke2,
                    fit: BoxFit.cover,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpace.xl,
              right: AppSpace.xl,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpace.xs),
                        child: Image.asset(Asset.logo, width: 25),
                      ),
                      Expanded(child: animatedText),
                      Image.asset(
                        Asset.iconShoppingBasket,
                        color: Colors.white,
                      ),
                      const SizedBox(width: AppSpace.xs),
                      Image.asset(
                        Asset.iconComments,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: !isExpanded ? 0 : AppSpace.md),
                  !isExpanded
                      ? Container()
                      : const AppInputSearch(
                          placeholder: 'Tìm kiếm sản phẩm ở đây...',
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverAppHeader extends StatelessWidget {
  const SliverAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).padding.top;

    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: AppPersistentHeaderDelegate(
        minHeight: paddingTop + 42, // 110
        maxHeight: paddingTop + 130,
      ),
    );
  }
}

class SimpleAppHeader extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppHeader(
    this.title, {
    super.key,
    this.leading,
    this.trailing,
    this.actions,
    this.back = true,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget>? actions;
  final bool back;

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget = leading ?? (back == false ? Container() : null);

    return AppBar(
      title: Text(
        title,
        style: AppStyle.textHeading2,
      ),
      iconTheme: const IconThemeData(
        color: AppColor.neutral,
      ),
      leading: leadingWidget,
      actions: actions,
      backgroundColor: AppColor.background,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
