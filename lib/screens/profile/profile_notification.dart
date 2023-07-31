import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/setting/setting_toggle.dart';
import 'package:flutter/material.dart';
import '../../constans/space.dart';

class ProfileNotificationScreen extends StatefulWidget {
  const ProfileNotificationScreen({super.key});

  @override
  State<ProfileNotificationScreen> createState() =>
      _ProfileNotificationScreenState();
}

class _ProfileNotificationScreenState extends State<ProfileNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SimpleAppHeader('Thông báo'),
      body: Padding(
        padding: EdgeInsets.all(AppSpace.xl),
        child: Column(
          children: [
            SettingToggleWidget(
              label: 'Thông báo chung',
              field: 'notification_general',
            ),
            SizedBox(height: AppSpace.xl),
            SettingToggleWidget(
              label: 'Âm thanh',
              field: 'notification_sound',
            ),
            SizedBox(height: AppSpace.xl),
            SettingToggleWidget(
              label: 'Rung khi thông báo',
              field: 'notifiaction_vibrate',
            ),
          ],
        ),
      ),
    );
  }
}
