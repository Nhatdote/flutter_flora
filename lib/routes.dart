import 'package:flora/screens/home.dart';
import 'package:flora/screens/onboarding.dart';
import 'package:flora/screens/profile.dart';
import 'package:flora/screens/register/otp.dart';
import 'package:flora/screens/register/phone.dart';
import 'package:flora/screens/splash.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String home = '/';
  static const String splash = '/splash';
  static const String onBoarding = '/onboarding';
  static const String profile = '/profile';

  static const String registerPhone = '/register/phone';
  static const String registerOtp = '/register/otp';
  static const String register = 'register';
  static const String registerSuccess = '/register/success';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      splash: (context) => const SplashScreen(),
      onBoarding: (context) => const OnBoardingScreen(),
      profile: (context) => const ProfileScreen(),
      registerPhone: (context) => const RegisterPhoneScreen(),
      registerOtp: (context) => const RegisterOtpScreen(),
      register: (context) => const ProfileScreen(),
      registerSuccess: (context) => const ProfileScreen(),
    };
  }
}
