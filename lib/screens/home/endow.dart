import 'package:flora/constans/style.dart';
import 'package:flutter/material.dart';

class EndowScreen extends StatefulWidget {
  const EndowScreen({super.key});

  @override
  State<EndowScreen> createState() => _EndowScreenState();
}

class _EndowScreenState extends State<EndowScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Endow',
        style: AppStyle.title,
      ),
    );
  }
}
