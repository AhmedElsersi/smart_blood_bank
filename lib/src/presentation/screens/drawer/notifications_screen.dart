import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/business_logic/layout_cubit/layout_cubit.dart';
import 'package:smart_blood_bank/src/presentation/widgets/loading_indicator.dart';

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
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 5.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: AppColors.red,
                                        )),
                                    child: DefaultText(
                                      text:
                                          cubit.notifications[index].message ??
                                              "",
                                      overflow: TextOverflow.ellipsis,
                                      textColor: Color(0xFF1E1E1E),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
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
