import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masnaay/src/business_logic/app_cubit/app_cubit.dart';
import 'package:masnaay/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:masnaay/src/business_logic/bloc_observer.dart';
import 'package:masnaay/src/constants/const_methods.dart';
import 'package:masnaay/src/constants/themes.dart';
import 'package:masnaay/src/localization/app_strings_extension.dart';
import 'package:masnaay/src/presentation/router/app_router.dart';
import 'package:masnaay/src/presentation/screens/start/splash_screen.dart';
import 'package:masnaay/src/services/cache_helper.dart';
import 'package:masnaay/src/services/dio_helper.dart';
import 'package:masnaay/src/services/network_checker_helper.dart';
import 'package:masnaay/src/services/notification_service.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
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
          create: (context) => AuthCubit(),
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
