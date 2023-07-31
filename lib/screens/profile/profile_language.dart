import 'package:flora/constans/space.dart';
import 'package:flora/getx/auth_state.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/setting/setting_radio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileLanguageScreen extends StatefulWidget {
  const ProfileLanguageScreen({super.key});

  @override
  State<ProfileLanguageScreen> createState() => _ProfileLanguageScreenState();
}

class _ProfileLanguageScreenState extends State<ProfileLanguageScreen> {
  AuthState auth = Get.find();
  List<Map<String, String>> languages = [
    {'label': 'Vietnamese', 'value': 'vi'},
    {'label': 'English', 'value': 'en'},
    {'label': 'Japanese', 'value': 'ja'},
    {'label': 'Chinese', 'value': 'cn'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppHeader('Ngôn ngữ'),
      body: Padding(
        padding: const EdgeInsets.all(AppSpace.xl),
        child: Obx(
          () => SettingRadioWidget(
            options: languages,
            selected: auth.settings['language'] ?? 'vi',
            onChanged: (String? value) {
              auth.settings['language'] = value!;
              auth.setUserSetting('language', value);
            },
          ),
        ),
      ),
    );
  }
}
