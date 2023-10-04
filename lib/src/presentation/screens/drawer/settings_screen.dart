import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notification = false;
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
          text: 'Settings',
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
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.icLanguage,
                                height: 23,
                                width: 23,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              const DefaultText(
                                text: 'Language',
                                textAlign: TextAlign.center,
                                fontSize: 22,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.h,
                      thickness: 2,
                      color: AppColors.tColor5,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.icNotifications,
                                height: 23,
                                width: 23,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              const DefaultText(
                                text: 'Notification',
                                textAlign: TextAlign.center,
                                fontSize: 22,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ],
                          ),
                          Transform.scale(
                            scale: 0.75,
                            child: CupertinoSwitch(
                                trackColor: AppColors.grey2,
                                activeColor: AppColors.primary,
                                value: notification,
                                onChanged: (value) {
                                  setState(() {
                                    notification = !notification;
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.h,
                      thickness: 2,
                      color: AppColors.tColor5,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
