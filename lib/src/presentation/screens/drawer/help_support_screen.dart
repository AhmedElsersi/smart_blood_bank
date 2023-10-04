import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router_names.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  menuList(BuildContext context) => <MenuModel>[
        MenuModel(
          icon: AppAssets.icContactUs,
          title: 'Contact Us',
          onTap: () {
            context.goTo(AppRouterNames.rContactUs);
          },
        ),
        MenuModel(
          icon: AppAssets.icChat,
          title: 'Chat With Us',
          onTap: () {
            // context.goTo(AppRouterNames.rHelpSupport);
          },
        ),
        MenuModel(
          icon: AppAssets.icTermsAndConditions,
          title: 'Terms and Conditions',
          onTap: () {
            context.goTo(AppRouterNames.rTermsAndConditions);
          },
        ),
        MenuModel(
          icon: AppAssets.icSendRequest,
          title: 'Send A Request',
          onTap: () {
            context.goTo(AppRouterNames.rSendARequest);
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        toolbarHeight: 60.h,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const DefaultText(
          text: 'Help Support',
          textColor: AppColors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 32.sp,
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            children: List.generate(
                menuList(context).length,
                (index) => HelpItemBuilder(
                      title: menuList(context)[index].title,
                      icon: menuList(context)[index].icon,
                      onTap: menuList(context)[index].onTap,
                    )),
          ),
        ),
      ),
    );
  }
}

class HelpItemBuilder extends StatelessWidget {
  final String? icon;
  final String title;
  final void Function()? onTap;
  const HelpItemBuilder({
    Key? key,
    this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    icon!,
                    height: 23,
                    width: 23,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  DefaultText(
                    text: title,
                    textAlign: TextAlign.center,
                    fontSize: 18,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Divider(
              height: 24.h,
              thickness: 2,
              color: AppColors.lightGrey,
            )
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
