import 'package:flora/constans/space.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/setting/setting_toggle.dart';
import 'package:flutter/material.dart';

class ProfileSecurityScreen extends StatefulWidget {
  const ProfileSecurityScreen({super.key});

  @override
  State<ProfileSecurityScreen> createState() => _ProfileSecurityScreenState();
}

class _ProfileSecurityScreenState extends State<ProfileSecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SimpleAppHeader('Bảo mật'),
      body: Padding(
        padding: EdgeInsets.all(AppSpace.xl),
        child: Column(
          children: [
            SettingToggleWidget(
              label: 'Ghi nhớ đăng nhập',
              field: 'keep_login',
            ),
            SizedBox(height: AppSpace.xl),
            SettingToggleWidget(
              label: 'Face ID / Touch ID',
              field: 'quick_login',
            ),
          ],
        ),
      ),
    );
  }
}
