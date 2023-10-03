import 'package:flutter/material.dart';
import 'package:masnaay/src/presentation/screens/auth/login_screen.dart';
import 'package:masnaay/src/presentation/screens/auth/otp_screen.dart';
import 'package:masnaay/src/presentation/screens/auth/register_screen.dart';
import 'package:masnaay/src/presentation/screens/drawer/about_screen.dart';
import 'package:masnaay/src/presentation/screens/drawer/settings_screen.dart';
import 'package:masnaay/src/presentation/screens/layout_screen.dart';
import 'package:masnaay/src/presentation/screens/start/on_boarding_screen.dart';
import 'package:masnaay/src/presentation/screens/start/splash_screen.dart';
import 'package:masnaay/src/presentation/screens/terms_and_conditions_screen.dart';

import 'app_router_names.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rSplash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case AppRouterNames.rOnBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
      case AppRouterNames.rLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case AppRouterNames.rOtp:
        return MaterialPageRoute(
          builder: (_) => const OtpScreen(),
        );
      case AppRouterNames.rRegister:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case AppRouterNames.rTermsAndConditions:
        return MaterialPageRoute(
          builder: (_) => const TermsAndConditionsScreen(),
        );
      case AppRouterNames.rLayout:
        return MaterialPageRoute(
          builder: (_) => const LayoutScreen(),
        );
      case AppRouterNames.rSettings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      case AppRouterNames.rAbout:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
        );
      default:
        return null;
    }
  }
}
