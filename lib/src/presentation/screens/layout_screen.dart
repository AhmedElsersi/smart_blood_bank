import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
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

class _LayoutScreenState extends State<LayoutScreen>
    with TickerProviderStateMixin {
  // List<String> iconList = [
  //   AppAssets.icNotifications,
  //   AppAssets.icFavorite,
  //   AppAssets.icProfile,
  //   AppAssets.icHome,
  // ];
  final GlobalKey<ScaffoldState> key = GlobalKey();
// TabController _tabController;
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    //// Use normal tab controller
    // _tabController = TabController(
    //   initialIndex: 1,
    //   length: 4,
    //   vsync: this,
    // );

    //// use "MotionTabBarController" to replace with "TabController", if you need to programmatically change the tab
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();

    // _tabController.dispose();
    _motionTabBarController!.dispose();
  }

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
        bottomNavigationBar: MotionTabBar(
          controller:
              _motionTabBarController, // ADD THIS if you need to change your tab programmatically
          initialSelectedTab: "Home",
          labels: const ["Dashboard", "Home", "Profile", "Settings"],
          icons: const [
            Icons.dashboard,
            Icons.home,
            Icons.people_alt,
            Icons.settings
          ],

          // optional badges, length must be same with labels
          badges: [
            // Default Motion Badge Widget
            const MotionBadgeWidget(
              text: '99+',
              textColor: Colors.white, // optional, default to Colors.white
              color: Colors.red, // optional, default to Colors.red
              size: 18, // optional, default to 18
            ),

            // custom badge Widget
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(2),
              child: const Text(
                '48',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),

            // allow null
            null,

            // Default Motion Badge Widget with indicator only
            const MotionBadgeWidget(
              isIndicator: true,
              color: Colors.red, // optional, default to Colors.red
              size: 5, // optional, default to 5,
              show: true, // true / false
            ),
          ],
          tabSize: 50,
          tabBarHeight: 55,
          textStyle: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          tabIconColor: Colors.blue[600],
          tabIconSize: 28.0,
          tabIconSelectedSize: 26.0,
          tabSelectedColor: Colors.blue[900],
          tabIconSelectedColor: Colors.white,
          tabBarColor: const Color(0xFFAFAFAF),
          onTabItemSelected: (int value) {
            setState(() {
              // _tabController!.index = value;
              _motionTabBarController!.index = value;
            });
          },
        ),
      );
    });
  }
}
