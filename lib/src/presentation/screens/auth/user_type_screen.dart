import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';

import '../../../constants/assets.dart';
import '../../../constants/const_methods.dart';
import '../../../constants/enums.dart';
import '../../router/app_router_names.dart';
import '../../widgets/default_button.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  bool patient = false;
  bool donner = false;
  bool hospital = false;
  bool bloodBank = false;

  String radioValue = '';

  int userTypeId = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 50.h, bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DefaultText(
                  text: 'قم باختيار نوع المستخدم بناءا علي الخدمة التي تحتاجها',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF1E1E1E),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () {
                    setState(() {
                      radioValue = 'patient';
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: radioValue == 'patient'
                            ? AppColors.red
                            : const Color(0xFFC8C8C8),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.icPatient),
                            SizedBox(
                              width: 8.w,
                            ),
                            const DefaultText(
                              text: 'مريض',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: Color(0xFF1E1E1E),
                            ),
                          ],
                        ),
                        Radio(
                            value: 'patient',
                            groupValue: radioValue,
                            activeColor: AppColors.red,
                            onChanged: (v) {
                              radioValue = v!;
                              setState(() {});
                            })
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      radioValue = 'donner';
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: radioValue == 'donner'
                            ? AppColors.red
                            : const Color(0xFFC8C8C8),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.icDonner),
                            SizedBox(
                              width: 8.w,
                            ),
                            const DefaultText(
                              text: 'متبرع',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: Color(0xFF1E1E1E),
                            ),
                          ],
                        ),
                        Radio(
                            value: 'donner',
                            groupValue: radioValue,
                            activeColor: AppColors.red,
                            onChanged: (v) {
                              radioValue = v!;
                              setState(() {});
                            })
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      radioValue = 'hospital';
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: radioValue == 'hospital'
                            ? AppColors.red
                            : const Color(0xFFC8C8C8),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                        Radio(
                            value: 'hospital',
                            groupValue: radioValue,
                            activeColor: AppColors.red,
                            onChanged: (v) {
                              radioValue = v!;
                              setState(() {});
                            })
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      radioValue = 'blood bank';
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: radioValue == 'blood bank'
                            ? AppColors.red
                            : const Color(0xFFC8C8C8),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.icBloodBank),
                            SizedBox(
                              width: 8.w,
                            ),
                            const DefaultText(
                              text: 'بنك دم ',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: Color(0xFF1E1E1E),
                            ),
                          ],
                        ),
                        Radio(
                            value: 'blood bank',
                            groupValue: radioValue,
                            activeColor: AppColors.red,
                            onChanged: (v) {
                              radioValue = v!;
                              setState(() {});
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: DefaultButton(
            margin: EdgeInsets.only(
                top: 3.h, bottom: 30.h, left: 16.w, right: 16.w),
            text: "متابعة",
            buttonColor: AppColors.red,
            textColor: AppColors.white,
            radius: 800,
            height: 40.h,
            onTap: () {
              if (radioValue == '') {
                showToast('نوع المستخدم مطلوب', ToastState.warning);
              } else {
                AuthCubit.get(context).userType = radioValue;
                Navigator.pushNamed(context, AppRouterNames.rRegister);
              }
            }),
      ),
    );
  }
}
