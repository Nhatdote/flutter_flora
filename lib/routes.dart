import 'package:flora/screens/home.dart';
import 'package:flora/screens/login.dart';
import 'package:flora/screens/onboarding.dart';
import 'package:flora/screens/profile.dart';
import 'package:flora/screens/register/form.dart';
import 'package:flora/screens/register/otp.dart';
import 'package:flora/screens/register/phone.dart';
import 'package:flora/screens/register/success.dart';
import 'package:flora/screens/splash.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String home = '/';
  static const String splash = '/splash';
  static const String onBoarding = '/onboarding';
  static const String profile = '/profile';

  static const String registerPhone = '/register/phone';
  static const String registerOtp = '/register/otp';
  static const String registerForm = 'register/form';
  static const String registerSuccess = '/register/success';

  static const String login = '/login';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      splash: (context) => const SplashScreen(),
      onBoarding: (context) => const OnBoardingScreen(),
      profile: (context) => const ProfileScreen(),
      registerPhone: (context) => const RegisterPhoneScreen(),
      registerOtp: (context) => const RegisterOtpScreen(),
      registerForm: (context) => const RegisterFormScreen(),
      registerSuccess: (context) => const RegisterSuccessScreen(),
      login: (context) => const LoginScreen()
    };
  }
}
