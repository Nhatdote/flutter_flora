import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/screens/home/cart.dart';
import 'package:flora/screens/home/endow.dart';
import 'package:flora/screens/home/home.dart';
import 'package:flora/screens/home/profile.dart';
import 'package:flora/widgets/flora_cam.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _screens = [
    {
      'widget': const HomeScreen(),
      'title': const Text(
        'Home screen',
        style: TextStyle(
          color: AppColor.neutral,
        ),
      ),
      'icon': Asset.iconHome,
      'iconActive': Asset.iconHomeSolid,
      'label': 'Trang chủ',
      'color': Colors.green
    },
    {
      'widget': const EndowScreen(),
      'title': const Text(
        'Endow screen',
        style: TextStyle(
          color: AppColor.neutral,
        ),
      ),
      'icon': Asset.iconCoupon,
      'iconActive': Asset.iconCouponSolid,
      'label': 'Ưu đãi',
      'color': Colors.redAccent
    },
    {'widget': Container(), 'label': ' ', 'icon': const Text(' ')},
    {
      'widget': const CartScreen(),
      'title': const Text(
        'Cart screen',
        style: TextStyle(
          color: AppColor.neutral,
        ),
      ),
      'icon': Asset.iconPackage,
      'iconActive': Asset.iconPackageSolid,
      'label': 'Giỏ hàng',
      'color': Colors.indigoAccent
    },
    {
      'widget': const ProfileScreen(),
      'title': const Text(
        'Home screen',
        style: TextStyle(
          color: AppColor.neutral,
        ),
      ),
      'icon': Asset.iconUser,
      'iconActive': Asset.iconUserSolid,
      'label': 'Cá nhân',
      'color': Colors.purpleAccent
    }
  ];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> currentScreen = _screens[_currentIndex];

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: currentScreen['title'],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens.map((h) => h['widget'] as Widget).toList(),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: AppColor.primary50,
              blurRadius: 10,
            )
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: AppColor.primary,
          onPressed: () {
            // Xử lý sự kiện khi nhấn nút FAB
          },
          child: const FloraCam(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
        clipBehavior: Clip.antiAlias,
        height: 60,
        color: Colors.white,
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          selectedItemColor: AppColor.primary,
          unselectedItemColor: AppColor.neutral40,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          elevation: 0,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: _screens
              .map(
                (h) => BottomNavigationBarItem(
                  icon: h['icon'].runtimeType == String
                      ? Image.asset(h['icon'], width: 20)
                      : h['icon'],
                  label: h['label'],
                  activeIcon: h['iconActive'].runtimeType == String
                      ? Image.asset(h['iconActive'], width: 20)
                      : h['iconActive'],
                  tooltip: h['label'],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
