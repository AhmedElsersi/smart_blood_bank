import 'package:flutter/material.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/forgot_password_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/login_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/otp_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/register_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/signup_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/dashboard_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/drawer/about_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/drawer/help_screens/contact_us_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/drawer/help_screens/send_request_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/drawer/help_support_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/drawer/settings_screen.dart';
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
          builder: (_) => const SignUpScreen(),
        );
      case AppRouterNames.rOtp:
        return MaterialPageRoute(
          builder: (_) => const OtpScreen(),
        );
      case AppRouterNames.rForgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
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
      case AppRouterNames.rDashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      case AppRouterNames.rSettings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      case AppRouterNames.rAbout:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
        );
      case AppRouterNames.rHelpSupport:
        return MaterialPageRoute(
          builder: (_) => const HelpSupportScreen(),
        );
      case AppRouterNames.rContactUs:
        return MaterialPageRoute(
          builder: (_) => const ContactUsScreen(),
        );
      case AppRouterNames.rSendARequest:
        return MaterialPageRoute(
          builder: (_) => const SendRequestScreen(),
        );
      default:
        return null;
    }
  }
}
