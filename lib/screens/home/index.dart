import 'package:camera/camera.dart';
import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/screens/flora_camera.dart';
import 'package:flora/screens/home/cart.dart';
import 'package:flora/screens/home/endow.dart';
import 'package:flora/screens/home/home.dart';
import 'package:flora/screens/home/profile.dart';
import 'package:flora/shared/toast.dart';
import 'package:flora/widgets/flora_floating_btn.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 0;
  CameraDescription? firstCamera;
  List<CameraDescription> _cameras = <CameraDescription>[];
  bool hasPermission = false;

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> requestCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _cameras = await availableCameras();
    } on CameraException catch (e) {
      print(
          'Error: $e.code${e.description == null ? '' : '\nError Message: $e.description'}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Toast.initialize(context);

    return Scaffold(
      backgroundColor: AppColor.background,
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
          onPressed: () async {
            if (!hasPermission) {
              await requestCamera();
            }

            // ignore: use_build_context_synchronously
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FloraCameraScreen(cameras: _cameras),
              ),
            );
          },
          child: const FloraFloatingBtn(),
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
                      ? Image.asset(
                          h['iconActive'],
                          width: 20,
                          color: AppColor.primary,
                        )
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
