import 'package:flora/constans/color.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flutter/material.dart';

class DesignSelectWrapScreen extends StatefulWidget {
  final List<int> ids;
  const DesignSelectWrapScreen(this.ids, {super.key});

  @override
  State<DesignSelectWrapScreen> createState() => _DesignSelectWrapScreenState();
}

class _DesignSelectWrapScreenState extends State<DesignSelectWrapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const SimpleAppHeader('Thiết kế'),
      body: Center(
        child: Text(
          'Bạn đã chọn ${widget.ids.join(', ')}',
          style: AppStyle.textHeading2,
        ),
      ),
    );
  }
}

class SectionWidget extends StatefulWidget {
  const SectionWidget({super.key});

  @override
  State<SectionWidget> createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
