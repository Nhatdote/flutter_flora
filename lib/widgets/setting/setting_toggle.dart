import 'package:flora/constans/color.dart';
import 'package:flora/constans/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../getx/auth_state.dart';

class SettingToggleWidget extends StatefulWidget {
  const SettingToggleWidget({
    super.key,
    required this.label,
    required this.field,
  });

  final String label;
  final String field;

  @override
  State<SettingToggleWidget> createState() => _SettingToggleWidgetState();
}

class _SettingToggleWidgetState extends State<SettingToggleWidget> {
  final AuthState auth = Get.find();
  late Map<dynamic, dynamic> settings = {};
  bool value = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      settings = auth.settings;
      value = settings[widget.field] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.label,
          style: AppStyle.textLabel,
        ),
        const Spacer(),
        CupertinoSwitch(
          activeColor: AppColor.primary,
          trackColor: AppColor.neutral40,
          value: value,
          onChanged: (_) {
            setState(() {
              value = !value;
            });

            auth.setUserSetting(widget.field, _);
          },
        )
      ],
    );
  }
}
