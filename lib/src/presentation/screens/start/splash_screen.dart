import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masnaay/src/constants/assets.dart';
import 'package:masnaay/src/constants/cache_keys.dart';
import 'package:masnaay/src/constants/colors.dart';
import 'package:masnaay/src/constants/const_variables.dart';
import 'package:masnaay/src/constants/navigator_extension.dart';
import 'package:masnaay/src/localization/app_strings_extension.dart';
import 'package:masnaay/src/presentation/router/app_router_names.dart';
import 'package:masnaay/src/presentation/widgets/default_text.dart';
import 'package:masnaay/src/services/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool firstTime =
        CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckFirstTime) ??
            true;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      firstTime
          ? {
              context.goToReplace(AppRouterNames.rOnBoarding),
            }
          : {
              isUser || isGuest
                  ? context.goToReplace(AppRouterNames.rLayout)
                  : context.goToReplace(AppRouterNames.rLogin)
            };
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Container(
        width: 1000.w,
        height: 1000.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // colors: [AppColors.gradientDark, AppColors.gradientLight]
            stops: [0, 0.25, 0.5, 0.75, 1],
            colors: [
              AppColors.gradientDark,
              AppColors.gradientSMid,
              AppColors.gradientMid,
              AppColors.gradientLMid,
              AppColors.gradientLight
            ],
          ),
        ),
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.icLogo,
            ),
            DefaultText(
              text: context.masnaay,
              fontSize: 36.sp,
              fontWeight: FontWeight.w400,
              textColor: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
