import 'package:flutter/material.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/login_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/otp_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/register_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/auth/user_type_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/ask_donation_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/donate_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/request_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/layout_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/start/on_boarding_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/start/splash_screen.dart';
import 'package:smart_blood_bank/src/presentation/screens/terms_and_conditions_screen.dart';

import '../screens/home/about_screen.dart';
import '../screens/home/ask_request_screen.dart';
import '../screens/home/ask_requests_screen.dart';
import '../screens/home/place_screen.dart';
import '../screens/home/places_screen.dart';
import '../screens/home/profile_screen.dart';
import '../screens/home/requests_screen.dart';
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
      case AppRouterNames.rDonate:
        return MaterialPageRoute(
          builder: (_) => const DonateScreen(),
        );
      case AppRouterNames.rAskDonation:
        final placeType = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => AskDonationScreen(
            placeType: placeType,
          ),
        );
      case AppRouterNames.rPlaces:
        final placeType = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => PlacesScreen(
            placeType: placeType,
          ),
        );
      case AppRouterNames.rPlace:
        final ids = settings.arguments as List<int>;
        return MaterialPageRoute(
          builder: (_) => PlaceScreen(
            ids: ids,
          ),
        );
      case AppRouterNames.rRequests:
        return MaterialPageRoute(
          builder: (_) => const RequestsScreen(),
        );
      case AppRouterNames.rRequest:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => RequestScreen(
            id: id,
          ),
        );
      case AppRouterNames.rAskRequests:
        return MaterialPageRoute(
          builder: (_) => const AskRequestsScreen(),
        );
      case AppRouterNames.rAskRequest:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => AskRequestScreen(
            id: id,
          ),
        );
      case AppRouterNames.rAbout:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
        );
      case AppRouterNames.rProfile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      default:
        return null;
    }
  }
}
