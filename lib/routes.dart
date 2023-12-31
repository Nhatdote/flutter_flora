import 'package:flora/screens/error.dart';
import 'package:flora/screens/faq.dart';
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
import 'package:flora/screens/profile/profile_favorite.dart';
import 'package:flora/screens/profile/profile_info.dart';
import 'package:flora/screens/profile/profile_language.dart';
import 'package:flora/screens/profile/profile_notification.dart';
import 'package:flora/screens/profile/profile_payment.dart';
import 'package:flora/screens/profile/profile_rank.dart';
import 'package:flora/screens/profile/profile_security.dart';
import 'package:flora/screens/profile/profile_setting.dart';
import 'package:flora/screens/profile/profile_voucher.dart';
import 'package:flora/screens/register/form.dart';
import 'package:flora/screens/register/otp.dart';
import 'package:flora/screens/register/phone.dart';
import 'package:flora/screens/register/success.dart';
import 'package:flora/screens/splash.dart';
import 'package:flora/screens/voucher/voucher_flora.dart';
import 'package:flora/screens/voucher/voucher_shop.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String index = '/index';
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
  static const String voucherShop = '/voucher/shop';
  static const String voucherFlora = '/voucher/flora';
  static const String profileRank = '/profile/rank';
  static const String profileInfo = '/profile/info';
  static const String profileFavorite = '/profile/favorite';
  static const String profileVoucher = '/profile/voucher';
  static const String profileSetting = '/profile/setting';
  static const String profileSecure = '/profile/secure';
  static const String profileNotification = '/profile/notification';
  static const String profileLanguage = '/profile/language';
  static const String profilePayment = '/profile/payment';
  static const String faq = '/faq';

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
    designCart: const DesignCartScreen(),
    voucherShop: const VoucherShopScreen(),
    voucherFlora: const VoucherFloraScreen(),
    profileRank: const ProfileRankScreen(),
    profileInfo: const ProfileInfoScreen(),
    profileFavorite: const ProfileFavoriteScreen(),
    profileVoucher: const ProfileVoucherScreen(),
    profileSetting: const ProfileSettingScreen(),
    profileSecure: const ProfileSecurityScreen(),
    profileNotification: const ProfileNotificationScreen(),
    profileLanguage: const ProfileLanguageScreen(),
    profilePayment: const ProfilePaymantScreen(),
    faq: const FaqScreen(),
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
