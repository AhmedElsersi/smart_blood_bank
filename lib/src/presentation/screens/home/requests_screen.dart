import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/donnation_cubit/donations_cubit.dart';
import '../../../constants/colors.dart';
import '../../router/app_router_names.dart';
import '../../widgets/default_text.dart';
import '../../widgets/loading_indicator.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  void initState() {
    DonationsCubit.get(context).getDonations();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DonationsCubit, DonationsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = DonationsCubit.get(context);
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
                  state is GetDonationsLoading
                      ? SizedBox(
                          height: 500.h,
                          child: const Center(child: LoadingIndicator()),
                        )
                      : cubit.donations.isNotEmpty
                          ? Expanded(
                              child: Container(
                              color: AppColors.white,
                              child: ListView.separated(
                                // padding: const EdgeInsets.only(top: 6),
                                itemBuilder: (context, index) {
                                  return DonationCard(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRouterNames.rRequest,
                                          arguments: 1);
                                    },
                                    title: cubit.donations[index].donor?.name ??
                                        "مصطفي حسام شوقي",
                                    location: "cubit.places[index].location",
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox();
                                },
                                // itemCount: 10,
                                itemCount: cubit.donations.length,
                              ),
                            ))
                          : SizedBox(
                              height: 500.h,
                              child: Center(
                                child: DefaultText(
                                  text: 'لا يوجد طلبات',
                                  textColor: Color(0xFF1E1E1E),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                ],
              ));
        });
  }
}

class DonationCard extends StatelessWidget {
  final VoidCallback onTap;
  final EdgeInsetsGeometry? margin;
  final String? title;
  final String? location;
  const DonationCard(
      {super.key, required this.onTap, this.margin, this.title, this.location});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin ??
            const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
        // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 130.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.red,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DefaultText(
                            text: 'تفاصيل الطلب',
                            overflow: TextOverflow.ellipsis,
                            textColor: Colors.red,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          const RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: AppColors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: DefaultText(
                      text: "الاسم : ${title ?? 'الامل'}",
                      overflow: TextOverflow.ellipsis,
                      textColor: const Color(0xFF1E1E1E),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: const BoxDecoration(
                  color: AppColors.red,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(15)),
                ),
                child: DefaultText(
                  text: 'فصيلة O+',
                  overflow: TextOverflow.ellipsis,
                  textColor: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
