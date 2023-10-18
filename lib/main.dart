import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/business_logic/app_cubit/app_cubit.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/business_logic/bloc_observer.dart';
import 'package:smart_blood_bank/src/business_logic/layout_cubit/layout_cubit.dart';
import 'package:smart_blood_bank/src/business_logic/places_cubit/places_cubit.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/themes.dart';
import 'package:smart_blood_bank/src/localization/app_strings_extension.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router.dart';
import 'package:smart_blood_bank/src/presentation/screens/start/splash_screen.dart';
import 'package:smart_blood_bank/src/services/cache_helper.dart';
import 'package:smart_blood_bank/src/services/dio_helper.dart';
import 'package:smart_blood_bank/src/services/network_checker_helper.dart';
import 'package:smart_blood_bank/src/services/notification_service.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      await Firebase.initializeApp();
      Bloc.observer = MyBlocObserver();
      await NotificationService.initialize();
      await CacheHelper.init();
      NetworkCheckerHelper.init();
      DioHelper.init();
      runApp(const MyApp());
    },
    (error, stackTrace) async {
      logError("Global Error: $error");
      logError("Global StackTrace: $stackTrace");
    },
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..initAppCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => AuthCubit(FirebaseAuth.instance),
        ),
        BlocProvider(
          create: (context) => LayoutCubit(),
        ),
        BlocProvider(
          create: (context) => PlacesCubit(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          return ScreenUtilInit(
            designSize: ScreenUtil.defaultSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                locale: cubit.locale,
                supportedLocales: supportedLocales,
                localizationsDelegates: localizationDelegates,
                onGenerateRoute: AppRouter.onGenerateRoutes,
                themeMode: cubit.themeMode,
                theme: LightTheme.lightTheme,
                darkTheme: DarkTheme.darkTheme,
                title: 'Smart Blood Bank',
              );
            },
            child: const SplashScreen(),
          );
        },
      ),
    );
  }
}
