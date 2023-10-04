import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/business_logic/layout_cubit/layout_cubit.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/const_variables.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router_names.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    super.initState();
  }

  menuList(BuildContext context) => <MenuModel>[
        MenuModel(
          icon: AppAssets.icAbout,
          title: 'About',
          onTap: () {
            context.goTo(AppRouterNames.rAbout);
          },
        ),
        MenuModel(
          icon: AppAssets.icHelp,
          title: 'Help Support',
          onTap: () {
            context.goTo(AppRouterNames.rHelpSupport);
          },
        ),
        MenuModel(
          icon: AppAssets.icSettings,
          title: 'Settings',
          onTap: () {
            context.goTo(AppRouterNames.rSettings);
          },
        ),
        MenuModel(
          icon: AppAssets.icLogout,
          title: 'Log Out',
          onTap: () {
            AuthCubit.get(context).logout();
            context.goTo(AppRouterNames.rLogin);
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: MediaQuery.of(context).size.width * 0.75,
        backgroundColor: AppColors.primary,
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Column(
            children: [
              const DefaultText(
                text: 'Masnaay',
                textAlign: TextAlign.center,
                fontSize: 25,
                textColor: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
              Divider(
                height: 30.h,
                color: AppColors.lightGrey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: isGuest
                          ? Container(
                              width: 49,
                              height: 49,
                              color: AppColors.white,
                              child: const Icon(Icons.person))
                          : SizedBox(
                              width: 49,
                              height: 49,
                              child: Image.asset(
                                AppAssets.imgProfile,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            text: 'Guest',
                            fontSize: 18,
                            textColor: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_sharp,
                                    color: AppColors.white,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  DefaultText(
                                    text: 'Location',
                                    fontSize: 15,
                                    textColor: AppColors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ],
                              ),
                              DefaultText(
                                text: isGuest ? 'login' : 'Edit',
                                fontSize: 14,
                                textColor: AppColors.white,
                                fontWeight: FontWeight.w400,
                                textDecoration: TextDecoration.underline,
                                onTap: () {
                                  if (isGuest) {
                                    context.goTo(AppRouterNames.rLogin);
                                  } else {
                                    Navigator.pop(context);
                                    BlocProvider.of<LayoutCubit>(context)
                                        .changePageIndex(2);
                                  }
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30.h,
                color: AppColors.lightGrey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: List.generate(
                      menuList(context).length,
                      (index) => isGuest && index == 4
                          ? const SizedBox()
                          : DrawerItemBuilder(
                              title: menuList(context)[index].title,
                              icon: menuList(context)[index].icon,
                              onTap: menuList(context)[index].onTap,
                              color: index == 2 ? AppColors.white : null,
                            )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItemBuilder extends StatelessWidget {
  final String? icon;
  final Color? color;
  final String title;
  final void Function()? onTap;
  const DrawerItemBuilder({
    Key? key,
    this.icon,
    required this.title,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          children: [
            SvgPicture.asset(
              icon!,
              color: color,
              height: 23,
              width: 23,
            ),
            SizedBox(
              width: 12.w,
            ),
            DefaultText(
              text: title,
              textAlign: TextAlign.center,
              fontSize: 15,
              textColor: AppColors.white,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuModel {
  final String? icon;
  final String title;
  final void Function() onTap;
  MenuModel({this.icon, required this.title, required this.onTap});
}
