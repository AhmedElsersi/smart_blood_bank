import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/business_logic/layout_cubit/layout_cubit.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';

import '../router/app_router_names.dart';
import '../widgets/layout/component/bottom_navigation_item.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with TickerProviderStateMixin {
  List<String> iconList = [
    AppAssets.icMenu,
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
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          height: 60.h,
          elevation: 10.h,
          notchMargin: 10.h,
          itemCount: 2,
          tabBuilder: (int index, bool isActive) {
            return BottomNavigationItem(
              onTap: () {
                cubit.changePageIndex(index);
              },
              icon: iconList[index],
              title: index == 0 ? 'المزيد' : 'الرئيسية',
              isActive: isActive,
            );
          },
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          activeIndex: cubit.pageIndex,
          onTap: (i) {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.red,
          onPressed: () {
            if (AuthCubit.get(context).userType == 'donner') {
              context.goTo(AppRouterNames.rDonate);
            }
          },
          clipBehavior: Clip.hardEdge,
          child: SvgPicture.asset(
            AuthCubit.get(context).userType == 'donner'
                ? AppAssets.icBlood
                : AppAssets.icGetBlood,
          ),
        ),
      );
    });
  }
}
