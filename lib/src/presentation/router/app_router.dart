import 'package:flutter/material.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/login_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/otp_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/register_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/user_type_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/layout_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/start/on_boarding_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/start/splash_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/terms_and_conditions_screen.dart';

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
      case AppRouterNames.rSignUp:
        return MaterialPageRoute(
          builder: (_) => const UserTypeScreen(),
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
      default:
        return null;
    }
  }
}
