import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/business_logic/places_cubit/places_cubit.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/presentation/screens/home/places_screen.dart';
import 'package:smart_blood_bank/src/presentation/widgets/loading_indicator.dart';

import '../../../constants/assets.dart';
import '../../../constants/cache_keys.dart';
import '../../../services/cache_helper.dart';
import '../../router/app_router_names.dart';
import '../../widgets/default_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Donor | Hospital | BloodBank | Recipient

  @override
  void initState() {
    logSuccess("userrrrrrrrrrrr ${AuthCubit.get(context).userType}");
    if (AuthCubit.get(context).userType == 'Recipient') {
      PlacesCubit.get(context).getHospitals();
    } else {
      PlacesCubit.get(context).getBloodBanks();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlacesCubit, PlacesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = PlacesCubit.get(context);
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultText(
                          text:
                              'مرحباً ، ${CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserName) ?? ''} ',
                          textColor: const Color(0xFF1E1E1E),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        SvgPicture.asset(AppAssets.icNotificationNew)
                      ],
                    ),
                    SizedBox(height: 20.h),
                    AuthCubit.get(context).userType != 'Recipient'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  logSuccess(AuthCubit.get(context).userType);
                                  if (AuthCubit.get(context).userType ==
                                          'Donor' ||
                                      AuthCubit.get(context).userType ==
                                          'Hospital') {
                                    context.goTo(AppRouterNames.rPlaces,
                                        args: 2);
                                  } else if (AuthCubit.get(context).userType ==
                                      'BloodBanks') {
                                    // context.goTo(AppRouterNames.rDonate);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h, horizontal: 12.w),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      DefaultText(
                                        text: AuthCubit.get(context).userType !=
                                                'BloodBank'
                                            ? 'بنوك الدم المتاحة للتبرع'
                                            : 'تقديم طلب لبحث عن متبرع',
                                        textColor: Color(0xFF1E1E1E),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      SvgPicture.asset(AppAssets.icPatient)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
                              if (AuthCubit.get(context).userType ==
                                  'BloodBank')
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DefaultText(
                                      text: 'الطلبات',
                                      textColor: Color(0xFF1E1E1E),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              context.goTo(
                                                  AppRouterNames.rPlaces,
                                                  args: 1);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 14.h,
                                                  horizontal: 12.w),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFC8C8C8)),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      AppAssets.icHospital),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  FittedBox(
                                                    child: DefaultText(
                                                      text: 'المستشفيات',
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textColor:
                                                          Color(0xFF1E1E1E),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              // context.goTo(AppRouterNames.rPersons, args: 1);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 14.h,
                                                  horizontal: 12.w),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFC8C8C8)),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      AppAssets.icDonnerPng),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  FittedBox(
                                                    child: DefaultText(
                                                      text: 'المتبرعين',
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textColor:
                                                          Color(0xFF1E1E1E),
                                                      onTap: () {
                                                        // CacheHelper.clearData();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30.h),
                                  ],
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: 'طلبات عاجلة',
                                    textColor: Color(0xFF1E1E1E),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  DefaultText(
                                    text: 'عرض الكل',
                                    textColor: Color(0xFFE53B43),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    onTap: () {
                                      //todo show all requests
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: 4,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Container(
                                  // padding: EdgeInsets.symmetric(
                                  //     vertical: 14.h, horizontal: 12.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFFC8C8C8)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                12.w, 8.h, 12.w, 8.h),
                                            decoration: const BoxDecoration(
                                                color: AppColors.red,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10))),
                                            child: DefaultText(
                                              text: 'فصيلة O+',
                                              textColor: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 16.w),
                                            padding: EdgeInsets.fromLTRB(
                                                16.w, 4.h, 16.w, 4.h),
                                            decoration: BoxDecoration(
                                                color: AuthCubit.get(context)
                                                            .userType ==
                                                        'donner'
                                                    ? null
                                                    : const Color(0xFFC8C8C8),
                                                border: AuthCubit.get(context)
                                                            .userType ==
                                                        'donner'
                                                    ? Border.all(
                                                        color: AppColors.red)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: AuthCubit.get(context)
                                                        .userType ==
                                                    'donner'
                                                ? DefaultText(
                                                    text: 'تبرع',
                                                    textColor: AppColors.red,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w700,
                                                  )
                                                : Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.male_rounded,
                                                        color:
                                                            Color(0xFF1E1E1E),
                                                      ),
                                                      DefaultText(
                                                        text: '24',
                                                        textColor:
                                                            Color(0xFF1E1E1E),
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            DefaultText(
                                              text: 'الاسم : ',
                                              textColor: Color(0xFF1E1E1E),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            DefaultText(
                                              text: 'مصطفي حسام شوقي',
                                              textColor: Color(0xFF1E1E1E),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            DefaultText(
                                              text: 'يحتاج : 9',
                                              textColor: Color(0xFF1E1E1E),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            DefaultText(
                                              text: ' وحدات ( المتبقي 4 )',
                                              textColor: Color(0xFF1E1E1E),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 10.h,
                                      // ),
                                      Divider(
                                        color: const Color(0xFFC8C8C8),
                                        height: 20.h,
                                      ),
                                      // SizedBox(
                                      //   height: 10.h,
                                      // ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              AuthCubit.get(context).userType ==
                                                      'donner'
                                                  ? MainAxisAlignment
                                                      .spaceBetween
                                                  : MainAxisAlignment.end,
                                          children: [
                                            if (AuthCubit.get(context)
                                                    .userType ==
                                                'donner')
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                      AppAssets.icLocation),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  DefaultText(
                                                    text:
                                                        'مستشفى الفتح الإسلامى',
                                                    textColor:
                                                        Color(0xFF1E1E1E),
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  12.w, 4.h, 12.w, 4.h),
                                              decoration: BoxDecoration(
                                                  color: AuthCubit.get(context)
                                                              .userType ==
                                                          'donner'
                                                      ? const Color(0xFFD3EADD)
                                                      : null,
                                                  border: AuthCubit.get(context)
                                                              .userType ==
                                                          'donner'
                                                      ? null
                                                      : Border.all(
                                                          color: AppColors.red),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  DefaultText(
                                                    text: AuthCubit.get(context)
                                                                .userType ==
                                                            'donner'
                                                        ? 'جاري الطلب'
                                                        : 'تفاصيل الطلب',
                                                    textColor:
                                                        AuthCubit.get(context)
                                                                    .userType ==
                                                                'donner'
                                                            ? const Color(
                                                                0xFF27AE60)
                                                            : AppColors.red,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  if (AuthCubit.get(context)
                                                          .userType !=
                                                      'donner')
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                  if (AuthCubit.get(context)
                                                          .userType !=
                                                      'donner')
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_rounded,
                                                      color: AppColors.red,
                                                      size: 13,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                text: 'أماكن للعثور لمتبرعين بالدم ',
                                textColor: const Color(0xFF1E1E1E),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(height: 10.h),
                              state is GetHospitalsSuccess
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return PlaceCard(
                                          hasMargin: true,
                                          onTap: () {
                                            // Navigator.pushNamed(context, rPlace);
                                          },
                                          title: cubit.places[index].name ??
                                              'الأمل',
                                          location:
                                              cubit.places[index].location ??
                                                  "مكة - مكة",
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox();
                                      },
                                      itemCount: cubit.places.length)
                                  : SizedBox(
                                      height: 300.h,
                                      child: const Center(
                                        child: LoadingIndicator(),
                                      ),
                                    ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
