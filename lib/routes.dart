import 'package:flora/screens/error.dart';
import 'package:flora/screens/feature/design/cart.dart';
import 'package:flora/screens/feature/design/select_flowers.dart';
import 'package:flora/screens/feature/design/select_shop.dart';
import 'package:flora/screens/feature/design/select_wrap.dart';
import 'package:flora/screens/feature/near_you.dart';
import 'package:flora/screens/feature/other.dart';
import 'package:flora/screens/feature/strange.dart';
import 'package:flora/screens/home/index.dart';
import 'package:flora/screens/login.dart';
import 'package:flora/screens/onboarding.dart';
import 'package:flora/screens/feature/promotion.dart';
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
  static const String promotion = '/promotion';
  static const String nearYou = '/near-you';
  static const String other = '/other';
  static const String strange = '/strange';
  static const String designSelectShop = '/design/select-shop';
  static const String designSelectFlowers = '/design/select-flowers';
  static const String designSelectWrap = '/design/select-wrap';
  static const String designCart = '/design/cart';

  // Routes is not have any agruments
  static Map<String, Widget> simpleRoutes = {
    index: const IndexScreen(),
    splash: const SplashScreen(),
    onBoarding: const OnBoardingScreen(),
    registerPhone: const RegisterPhoneScreen(),
    registerSuccess: const RegisterSuccessScreen(),
    login: const LoginScreen(),
    nearYou: const NearYouScreen(),
    other: const OtherScreen(),
    strange: const StrangeScreen(),
    designSelectShop: const DesignSelectShopScreen(),
    designSelectFlowers: const DesignSelectFlowersScreen(),
    designSelectWrap: const DesignSelectWrapScreen(),
    designCart: const DesignCartScreen()
  };

  // @TODO
  static Map<String, dynamic> nestedRoutes = {};

  static onGenerateRoute(RouteSettings settings) {
    final String? routeName = settings.name;
    final Map<String, dynamic>? arguments =
        settings.arguments as Map<String, dynamic>?;
    final Map<String, Widget> routes = AppRoute.simpleRoutes;
    final Widget? screen;

    switch (routeName) {
      case AppRoute.registerOtp:
        if (arguments == null || arguments['phone'] == null) {
          return errorPage();
        }

        screen = RegisterOtpScreen(phone: arguments['phone']!);
        break;
      case AppRoute.registerForm:
        if (arguments == null || arguments['phone'] == null) {
          return errorPage();
        }

        screen = RegisterFormScreen(phone: arguments['phone']!);
        break;
      case AppRoute.promotion:
        if (arguments == null || arguments['promotion'] == null) {
          return errorPage();
        }

        screen = PromotionScreen(promotion: arguments['promotion']!);
        break;
      // case AppRoute.designCart:
      //   final DesignState state = Get.find();

      //   print('${state.wrap}, ${state.arrangement}');

      //   screen = const DesignCartScreen();
      //   break;
      default:
        screen = routes.containsKey(routeName) ? routes[routeName] : null;
        break;
    }

    if (screen == null) {
      return errorPage();
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) => screen!,
      settings: settings,
    );
  }

  static errorPage({String? message, String? image}) {
    return MaterialPageRoute<dynamic>(
      builder: (context) => ErrorScreen(
        messsage: message,
        image: image,
      ),
      settings: const RouteSettings(),
    );
  }
}
