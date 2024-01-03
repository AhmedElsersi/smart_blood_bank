import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_blood_bank/src/business_logic/layout_cubit/layout_cubit.dart';
import 'package:smart_blood_bank/src/presentation/widgets/loading_indicator.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../widgets/default_text.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    LayoutCubit.get(context).getNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = LayoutCubit.get(context);
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
                  state is GetNotificationsSuccess
                      ? cubit.notifications.isNotEmpty
                          ? Expanded(
                              child: Container(
                              color: AppColors.white,
                              child: ListView.separated(
                                // padding: const EdgeInsets.only(top: 6),
                                itemBuilder: (context, index) {
                                  return PlaceCard(
                                    onTap: () {},
                                    title:
                                        cubit.notifications[index].name ?? "",
                                    location:
                                        cubit.notifications[index].location ??
                                            "",
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox();
                                },
                                itemCount: cubit.notifications.length,
                              ),
                            ))
                          : SizedBox(
                              height: 500.h,
                              child: Center(
                                child: DefaultText(
                                  text: 'لا يوجد اشعارات',
                                  textColor: Color(0xFF1E1E1E),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
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
  final String? title;
  final String? location;
  const PlaceCard(
      {super.key,
      required this.onTap,
      this.hasMargin,
      this.title,
      this.location});

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
          border: Border.all(color: AppColors.grey),
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
