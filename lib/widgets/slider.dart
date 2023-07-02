import 'package:flutter/material.dart';

class AppSlider extends StatefulWidget {
  final List<dynamic> items;

  const AppSlider({super.key, required this.items});

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> items = widget.items;

    return PageView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Image.asset(items[index]);
      },
    );
  }
}
