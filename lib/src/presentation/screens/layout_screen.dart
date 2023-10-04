import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_blood_bank/src/business_logic/layout_cubit/layout_cubit.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';

import '../../constants/const_variables.dart';
import '../widgets/default_text.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  // List<String> iconList = [
  //   AppAssets.icNotifications,
  //   AppAssets.icFavorite,
  //   AppAssets.icProfile,
  //   AppAssets.icHome,
  // ];
  final GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(listener: (context, state) {
      if (state is DrawerOpened) {
        key.currentState?.openDrawer();
      }
    }, builder: (context, state) {
      final cubit = BlocProvider.of<LayoutCubit>(context);
      return Scaffold(
        key: key,
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultText(
                    text: 'مرحباً ، ${user} ',
                    textColor: const Color(0xFF1E1E1E),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  SvgPicture.asset(AppAssets.icNotificationNew)
                ],
              ),
              SizedBox(height: 30.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const DefaultText(
                      text: 'تبرع الأن و أنقذ حياة مريض',
                      textColor: Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    SvgPicture.asset(AppAssets.icPatient)
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              const DefaultText(
                text: 'أماكن لتبرع',
                textColor: Color(0xFF1E1E1E),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 14.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFF5F5F5)),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.icHospital),
                          SizedBox(
                            width: 8.w,
                          ),
                          const DefaultText(
                            text: 'مستشفي ',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            textColor: Color(0xFF1E1E1E),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 14.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFF5F5F5)),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.icBloodBank),
                          SizedBox(
                            width: 8.w,
                          ),
                          DefaultText(
                            text: 'بنك دم ',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            textColor: Color(0xFF1E1E1E),
                            onTap: () {
                              // CacheHelper.clearData();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        // bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        //   height: 54.h,
        //   elevation: 10.h,
        //   notchMargin: 10.h,
        //   itemCount: 4,
        //   tabBuilder: (int index, bool isActive) {
        //     return BottomNavigationItem(
        //       onTap: () {
        //         cubit.changePageIndex(index);
        //       },
        //       icon: iconList[index],
        //       isActive: isActive,
        //     );
        //   },
        //   gapLocation: GapLocation.center,
        //   notchSmoothness: NotchSmoothness.sharpEdge,
        //   activeIndex: cubit.pageIndex,
        //   onTap: (i) {},
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: AppColors.primary,
        //   onPressed: () {
        //     if (isGuest) {
        //       showToast('You need to login first', ToastState.warning);
        //     } else {
        //       context.goTo(AppRouterNames.rDashboard);
        //     }
        //   },
        //   clipBehavior: Clip.hardEdge,
        //   child: Icon(
        //     Icons.add_rounded,
        //     size: 30.h,
        //   ),
        // ),
      );
    });
  }
}
