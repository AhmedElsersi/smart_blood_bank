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

import '../../../business_logic/donnation_cubit/donations_cubit.dart';
import '../../../constants/assets.dart';
import '../../../constants/cache_keys.dart';
import '../../../services/cache_helper.dart';
import '../../router/app_router_names.dart';
import '../../widgets/default_text.dart';
import 'ask_requests_screen.dart';

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
    } else if (AuthCubit.get(context).userType == 'BloodBank') {
      DonationsCubit.get(context).getAskDonations();
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
                                      'BloodBank') {
                                    context.goTo(AppRouterNames.rDonate);
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
                                              context.goTo(
                                                  AppRouterNames.rRequests,
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
                                                    BorderRadius.circular(8),
                                              ),
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
                                      context.goTo(AppRouterNames.rAskRequests);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              BlocConsumer<DonationsCubit, DonationsState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    final cubit = DonationsCubit.get(context);
                                    return state is GetAskDonationsLoading
                                        ? SizedBox(
                                            height: 200.h,
                                            child: const Center(
                                                child: LoadingIndicator()),
                                          )
                                        : cubit.askDonations.isEmpty
                                            ? SizedBox(
                                                height: 200.h,
                                                child: Center(
                                                  child: DefaultText(
                                                    text: 'لا يوجد طلبات',
                                                    textColor:
                                                        Color(0xFF1E1E1E),
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )
                                            : Expanded(
                                                child: Container(
                                                color: AppColors.white,
                                                child: ListView.separated(
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return AskDonationCard(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            AppRouterNames
                                                                .rAskRequest,
                                                            arguments: cubit
                                                                    .askDonations[
                                                                        index]
                                                                    .id ??
                                                                1);
                                                      },
                                                      title: cubit
                                                              .askDonations[
                                                                  index]
                                                              .patientName ??
                                                          "مصطفي حسام شوقي",
                                                      location: cubit
                                                          .askDonations[index]
                                                          .hospitalId,
                                                      date: cubit
                                                          .askDonations[index]
                                                          .date,
                                                      bloodType: cubit
                                                          .askDonations[index]
                                                          .bloodType,
                                                      units: (cubit
                                                                  .askDonations[
                                                                      index]
                                                                  .quantity ??
                                                              9)
                                                          .toDouble(),
                                                    );
                                                  },
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),

                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const SizedBox();
                                                  },
                                                  // itemCount: 10,
                                                  itemCount:
                                                      cubit.askDonations.length,
                                                ),
                                              ));
                                  }),
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
                                            Navigator.pushNamed(
                                              context,
                                              AppRouterNames.rPlace,
                                              arguments: [
                                                1,
                                                cubit.places[index].id!
                                              ],
                                            );
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
