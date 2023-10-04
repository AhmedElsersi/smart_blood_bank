import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/business_logic/layout_cubit/layout_cubit.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/const_variables.dart';
import 'package:smart_blood_bank/src/constants/enums.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router_names.dart';
import 'package:smart_blood_bank/src/presentation/widgets/layout/component/bottom_navigation_item.dart';

import 'home/drawer.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  List<String> iconList = [
    AppAssets.icNotifications,
    AppAssets.icFavorite,
    AppAssets.icProfile,
    AppAssets.icHome,
  ];
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
        body: cubit.layoutPages.elementAt(cubit.pageIndex),
        extendBodyBehindAppBar: true,
        drawer: SizedBox(
          width: (MediaQuery.of(context).size.width * 0.75) + 30.w,
          child: Stack(
            children: [
              const DrawerScreen(),
              Positioned(
                top: 26.h,
                left: (MediaQuery.of(context).size.width * 0.75) - 2,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 30.w,
                    height: 30.w,
                    color: AppColors.gradientDark.withOpacity(0.79),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 28,
                      color: AppColors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          height: 54.h,
          elevation: 10.h,
          notchMargin: 10.h,
          itemCount: 4,
          tabBuilder: (int index, bool isActive) {
            return BottomNavigationItem(
              onTap: () {
                cubit.changePageIndex(index);
              },
              icon: iconList[index],
              isActive: isActive,
            );
          },
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.sharpEdge,
          activeIndex: cubit.pageIndex,
          onTap: (i) {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            if (isGuest) {
              showToast('You need to login first', ToastState.warning);
            } else {
              context.goTo(AppRouterNames.rDashboard);
            }
          },
          clipBehavior: Clip.hardEdge,
          child: Icon(
            Icons.add_rounded,
            size: 30.h,
          ),
        ),
      );
    });
  }
}
