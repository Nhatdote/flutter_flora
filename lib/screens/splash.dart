import 'package:flora/db.dart';
import 'package:flora/routes.dart';
import 'package:flora/widgets/logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    initFlora(context);
  }

  void initFlora(thisContext) async {
    await DB.init();

    await Future.delayed(const Duration(seconds: 1));

    final bool isSkip = DB.prefs.getBool(DB.skipOnBoarding) ?? false;

    Navigator.pushReplacementNamed(
      thisContext,
      isSkip ? AppRoute.login : AppRoute.onBoarding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Logo()),
    );
  }
}
