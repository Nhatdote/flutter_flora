import 'package:flora/db.dart';
import 'package:flora/getx/auth_state.dart';
import 'package:flora/models/user.dart';
import 'package:flora/routes.dart';
import 'package:flora/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final AuthState auth = AuthState();
    Get.put(auth);

    final bool isSkip = DB.prefs.getBool(DB.skipOnBoarding) ?? false;
    final User? loginUser = auth.getLoginUser();

    String routeName = AppRoute.onBoarding;
    if (isSkip) {
      routeName = loginUser != null ? AppRoute.index : AppRoute.login;
    }

    Navigator.pushNamedAndRemoveUntil(
      thisContext,
      routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Logo()),
    );
  }
}
