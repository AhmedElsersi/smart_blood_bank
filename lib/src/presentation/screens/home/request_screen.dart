import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/business_logic/places_cubit/places_cubit.dart';

import '../../../constants/colors.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key, required this.id});

  final int id;

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
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
              body: Container(
                width: 390,
                height: 844,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: EdgeInsets.all(16.w),
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
                    Text(
                      'تفاصيل الطلب',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Container(
                      width: 348,
                      height: 50,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 183,
                            top: 0,
                            child: Container(
                              width: 165,
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 165,
                                      height: 50,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFE53B43),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 64,
                                    top: 10,
                                    child: Text(
                                      'قبول',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 165,
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 165,
                                      height: 50,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 2,
                                              color: Color(0xFFE53B43)),
                                          borderRadius:
                                              BorderRadius.circular(60),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 65,
                                    top: 10,
                                    child: Text(
                                      'رفض',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFE53B43),
                                        fontSize: 16,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 349,
                      height: 304,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 349,
                              height: 304,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 349,
                                      height: 304,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 1,
                                            top: 0,
                                            child: Container(
                                              width: 348,
                                              height: 304,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Color(0xFFC8C8C8)),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 28,
                                            top: 28.68,
                                            child: Container(
                                              width: 50,
                                              height: 47.80,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 23,
                                            top: 22.94,
                                            child: Container(
                                              width: 303,
                                              height: 52.58,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: 303,
                                                    height: 55,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 95,
                                                          top: 17,
                                                          child: Text(
                                                            'مصطفي حسام شوقي',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF1E1E1E),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 248,
                                                          top: 0,
                                                          child: Container(
                                                            width: 55,
                                                            height: 55,
                                                            decoration:
                                                                ShapeDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: NetworkImage(
                                                                    "https://via.placeholder.com/55x55"),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              shape:
                                                                  OvalBorder(),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 0,
                                                          top: 12,
                                                          child: Container(
                                                            width: 35,
                                                            height: 35,
                                                            child: Stack(
                                                              children: [
                                                                Positioned(
                                                                  left: 0,
                                                                  top: 0,
                                                                  child:
                                                                      Container(
                                                                    width: 35,
                                                                    height: 35,
                                                                    decoration:
                                                                        ShapeDecoration(
                                                                      color: Color(
                                                                          0xFFE53B43),
                                                                      shape:
                                                                          OvalBorder(),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 98.47,
                                            child: Container(
                                              width: 347.09,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 1,
                                                    strokeAlign: BorderSide
                                                        .strokeAlignCenter,
                                                    color: Color(0xFFC8C8C8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 67,
                                    top: 127,
                                    child: Text.rich(
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
                                            text: ' يريد التبرع ',
                                            style: TextStyle(
                                              color: Color(0xFF1E1E1E),
                                              fontSize: 14,
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'لحالة أيمن إبراهيم',
                                            style: TextStyle(
                                              color: Color(0xFFE53B43),
                                              fontSize: 14,
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Positioned(
                                    left: 49,
                                    top: 177,
                                    child: Text.rich(
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 257,
                            top: 262,
                            child: Text.rich(
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
