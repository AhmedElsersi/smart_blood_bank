import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router_names.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';

import '../../../constants/cache_keys.dart';
import '../../../services/cache_helper.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  void dispose() {
    super.dispose();
  }

  bool editing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(children: [
          Container(
            // height: 180.h,
            color: AppColors.primary,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.fromLTRB(12.w, 25.h, 12.w, 18.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.icLogo,
                  color: AppColors.white,
                ),
                SizedBox(
                  height: 22.h,
                ),
                InkWell(
                  onTap: () {
                    context.goTo(AppRouterNames.rProfile);
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.perm_identity_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      DefaultText(
                        text:
                            "${CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserName) ?? ''}",
                        textColor: AppColors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    context.goTo(AppRouterNames.rAbout);
                  },
                  child: Row(
                    children: [
                      const RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.error_outline_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      DefaultText(
                        text: 'حول التطبيق',
                        textColor: Color(0xFF1E1E1E),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: () async {
                    await CacheHelper.clearData();
                    context.goTo(AppRouterNames.rLogin);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: AppColors.red,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      DefaultText(
                        text: 'تسجيل خروج',
                        textColor: Color(0xFF1E1E1E),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
