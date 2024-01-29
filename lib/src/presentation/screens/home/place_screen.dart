import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_blood_bank/src/business_logic/places_cubit/places_cubit.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_button.dart';
import 'package:smart_blood_bank/src/presentation/widgets/loading_indicator.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/const_methods.dart';
import '../../router/app_router_names.dart';
import '../../widgets/default_text.dart';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({super.key, required this.ids});

  ///0:::  1:hospital , 2:blood bank
  ///0:::  hospital or blood bank id

  final List<dynamic> ids;

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  @override
  void initState() {
    if (widget.ids[0] == 1) {
      PlacesCubit.get(context).getHospital(id: widget.ids[1]);
    } else {
      PlacesCubit.get(context).getBloodBank(id: widget.ids[1]);
    }
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
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  state is GetBloodBankSuccess || state is GetHospitalSuccess
                      ? Expanded(
                          child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PlaceCard(
                                hasBorder: false,
                                onTap: () {},
                                title: cubit.placeModel.data?.name ?? '',
                                location: cubit.placeModel.data?.location ?? '',
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    aboutCollapsed = !aboutCollapsed;
                                  });
                                },
                                child: Container(
                                  height: 50.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFFC8C8C8)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'عن ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF1E1E1E),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 0.05,
                                        ),
                                      ),
                                      const RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xFF1E1E1E),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (!aboutCollapsed)
                                SizedBox(
                                  height: 10.h,
                                ),
                              if (!aboutCollapsed)
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: DefaultText(
                                    text: cubit.placeModel.data?.about ??
                                        'عن المكان',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    bloodTypesCollapsed = !bloodTypesCollapsed;
                                  });
                                },
                                child: Container(
                                  height: 50.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFFC8C8C8)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'فصائل الدم المتوفرة',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF1E1E1E),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 0.05,
                                        ),
                                      ),
                                      const RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xFF1E1E1E),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (!bloodTypesCollapsed)
                                SizedBox(
                                  height: 10.h,
                                ),
                              if (!bloodTypesCollapsed)
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: SizedBox(
                                      height: 100.h,
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          childAspectRatio: 1.5,
                                          crossAxisSpacing: 10.h,
                                          mainAxisSpacing: 10.h,
                                        ),
                                        padding: EdgeInsets.zero,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: cubit
                                            .placeModel.data?.bloodTypes
                                            ?.replaceAll('[', '')
                                            .replaceAll(']', '')
                                            .split(',')
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                Container(
                                          // padding:
                                          //     EdgeInsets.fromLTRB(0.w, 1.h, 0.w, 1.h),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.red),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: DefaultText(
                                            text: cubit
                                                    .placeModel.data?.bloodTypes
                                                    ?.replaceAll('[', '')
                                                    .replaceAll(']', '')
                                                    .split(',')[index] ??
                                                '',
                                            textColor: AppColors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    )),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    contactCollapsed = !contactCollapsed;
                                  });
                                },
                                child: Container(
                                  height: 50.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFFC8C8C8)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'معلومات التواصل ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF1E1E1E),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 0.05,
                                        ),
                                      ),
                                      const RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xFF1E1E1E),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (!contactCollapsed)
                                SizedBox(
                                  height: 10.h,
                                ),
                              if (!contactCollapsed)
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: DefaultText(
                                    text:
                                        cubit.placeModel.data?.contactDetails ??
                                            'معلومات التواصل',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              SizedBox(
                                height: 30.h,
                              ),
                              DefaultButton(
                                onTap: () {
                                  logSuccess(AuthCubit.get(context).userType);
                                  if (AuthCubit.get(context).userType ==
                                      'Donor') {
                                    context.goTo(AppRouterNames.rDonate);
                                  } else if (AuthCubit.get(context).userType ==
                                      'Recipient') {
                                    context.goTo(AppRouterNames.rAskDonation,
                                        args: widget.ids[0]);
                                  }
                                },
                                height: 40.h,
                                radius: 100,
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                width: double.infinity,
                                buttonColor: AppColors.red,
                                textColor: AppColors.white,
                                text: AuthCubit.get(context).userType ==
                                        'Recipient'
                                    ? 'طلب متبرع'
                                    : 'حجز كمتبرع',
                              )
                            ],
                          ),
                        ))
                      : SizedBox(
                          height: 500.h,
                          child: const Center(child: LoadingIndicator()),
                        ),
                ],
              ));
        });
  }
}

class PlaceCard extends StatelessWidget {
  final VoidCallback onTap;
  final bool? hasMargin;
  final bool? hasBorder;
  final String? title;
  final String? location;
  const PlaceCard(
      {super.key,
      required this.onTap,
      this.hasMargin,
      this.title,
      this.location,
      this.hasBorder});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: (hasMargin ?? false)
            ? const EdgeInsets.only(
                bottom: 20,
              )
            : const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: hasBorder ?? true ? Border.all(color: AppColors.grey) : null,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              height: 80.h,
              width: 80.h,
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  AppAssets.imgHospital,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: DefaultText(
                        text: title ?? 'الامل',
                        overflow: TextOverflow.ellipsis,
                        textColor: Color(0xFF1E1E1E),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.icLocation),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                          child: DefaultText(
                            text: location ?? 'مكة - مكة',
                            overflow: TextOverflow.ellipsis,
                            textColor: Color(0xFF1E1E1E),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
