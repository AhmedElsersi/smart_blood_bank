import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/business_logic/places_cubit/places_cubit.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_button.dart';

import '../../../constants/colors.dart';
import '../../widgets/default_text.dart';

class AskRequestScreen extends StatefulWidget {
  const AskRequestScreen({super.key, required this.id});

  final int id;

  @override
  State<AskRequestScreen> createState() => _AskRequestScreenState();
}

class _AskRequestScreenState extends State<AskRequestScreen> {
  @override
  void initState() {
    // PlacesCubit.get(context).getBloodBank();

    super.initState();
  }

  bool aboutCollapsed = true;
  bool bloodTypesCollapsed = true;
  bool contactCollapsed = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlacesCubit, PlacesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = PlacesCubit.get(context);
          return Scaffold(
              backgroundColor: AppColors.white,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: EdgeInsets.fromLTRB(16.w, 50.h, 0.w, 20.h),
                        decoration: const BoxDecoration(
                            color: Color(0xFFC8C8C8), shape: BoxShape.circle),
                        child: const RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const DefaultText(
                      text: 'تفاصيل الطلب',
                      textAlign: TextAlign.center,
                      textColor: Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20.h, horizontal: 0.w),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const DefaultText(
                                text: 'مصطفي حسام شوقي',
                                textAlign: TextAlign.center,
                                textColor: Color(0xFF1E1E1E),
                                fontSize: 14,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFE53B43),
                                  shape: OvalBorder(),
                                ),
                                child: const Icon(
                                  Icons.call,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 30.h,
                            color: AppColors.grey,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14.sp,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              DefaultText(
                                text: 'مستشفي الملك فيصل',
                                overflow: TextOverflow.ellipsis,
                                textColor: const Color(0xFF1E1E1E),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'ذكر',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' يبلغ',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' 24 عام',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' يحتاج الي ',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' 9 وحدات ',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' من الدم ',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'في التاريخ المحدد',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' 9 أكتوبر 2023',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' في تمام الساعة\n',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' 00 : 09 مساءاً',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'الفصيلة :',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' O+',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DefaultButton(
                            height: 40.h,
                            radius: 100,
                            text: 'قبول',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            textColor: AppColors.white,
                            buttonColor: AppColors.red,
                            onTap: () {},
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: DefaultButton(
                            height: 40.h,
                            radius: 100,
                            text: 'رفض',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            textColor: AppColors.red,
                            border: Border.all(color: AppColors.red),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
