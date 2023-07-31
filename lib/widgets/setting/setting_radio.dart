import 'package:flora/constans/style.dart';
import 'package:flutter/material.dart';

class SettingRadioWidget extends StatefulWidget {
  const SettingRadioWidget({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<Map<String, String>> options;
  final dynamic selected;
  final void Function(String?) onChanged;

  @override
  State<SettingRadioWidget> createState() => _SettingRadioWidgetState();
}

class _SettingRadioWidgetState extends State<SettingRadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((h) {
        return InkWell(
          onTap: () => widget.onChanged(h['value']),
          child: Row(
            children: [
              Text(h['label']!, style: AppStyle.textLabel),
              const Spacer(),
              IgnorePointer(
                ignoring: true,
                child: Radio<String>(
                  value: h['value']!,
                  groupValue: widget.selected,
                  onChanged: (value) {},
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
