import 'package:flora/screens/error.dart';
import 'package:flora/screens/home/index.dart';
import 'package:flora/screens/login.dart';
import 'package:flora/screens/onboarding.dart';
import 'package:flora/screens/register/form.dart';
import 'package:flora/screens/register/otp.dart';
import 'package:flora/screens/register/phone.dart';
import 'package:flora/screens/register/success.dart';
import 'package:flora/screens/splash.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String index = '/';

  static const String splash = '/splash';
  static const String onBoarding = '/onboarding';
  static const String registerPhone = '/register/phone';
  static const String registerOtp = '/register/otp';
  static const String registerForm = 'register/form';
  static const String registerSuccess = '/register/success';
  static const String login = '/login';

  // Routes is not have any agruments
  static Map<String, Widget> simpleRoutes = {
    index: const IndexScreen(),
    splash: const SplashScreen(),
    onBoarding: const OnBoardingScreen(),
    registerPhone: const RegisterPhoneScreen(),
    registerSuccess: const RegisterSuccessScreen(),
    login: const LoginScreen()
  };

  static onGenerateRoute(RouteSettings settings) {
    final String? routeName = settings.name;
    final Map<String, String>? arguments =
        settings.arguments as Map<String, String>?;
    final Map<String, Widget> routes = AppRoute.simpleRoutes;
    final Widget? screen;

    switch (routeName) {
      case AppRoute.registerOtp:
        if (arguments == null || arguments['phone'] == null) {
          return errprPage();
        }

        screen = RegisterOtpScreen(phone: arguments['phone']!);
        break;
      case AppRoute.registerForm:
        if (arguments == null || arguments['phone'] == null) {
          return errprPage();
        }

        screen = RegisterFormScreen(phone: arguments['phone']!);
        break;
      default:
        screen = routes.containsKey(routeName) ? routes[routeName] : null;
        break;
    }

    if (screen == null) {
      throw Exception('Unknown route: $routeName');
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) => screen!,
      settings: settings,
    );
  }

  static errprPage({String? message, String? image}) {
    return MaterialPageRoute<dynamic>(
      builder: (context) => ErrorScreen(
        messsage: message,
        image: image,
      ),
      settings: const RouteSettings(),
    );
  }
}
