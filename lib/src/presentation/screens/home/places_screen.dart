import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../widgets/default_text.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key, required this.placeType});

  /// 1:hospital , 2: blood bank
  final int placeType;

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            // CustomAppBar(
            //   padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
            //   title: 'المطاعم',
            //   leading: InkWell(
            //       onTap: () {
            //         Navigator.pop(context);
            //       },
            //       child: SvgPicture.asset(AppAssets.icArrowRight)),
            //   actions: InkWell(
            //       onTap: () {
            //         Navigator.pushNamed(context, rSearch);
            //       },
            //       child: SvgPicture.asset(AppAssets.icSearch)),
            // ),
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
            Expanded(
                child: Container(
              color: AppColors.white,
              child: ListView.separated(
                  // padding: const EdgeInsets.only(top: 6),
                  itemBuilder: (context, index) {
                    return PlaceCard(
                      onTap: () {
                        // Navigator.pushNamed(context, rPlace);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox();
                  },
                  itemCount: 10),
            )),
          ],
        ));
  }
}

class PlaceCard extends StatelessWidget {
  final VoidCallback onTap;
  const PlaceCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
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
        child: Column(
          children: [
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  AppAssets.imgHospital,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const DefaultText(
                    text: 'مستشفي السلام الدولي التخصصي',
                    overflow: TextOverflow.ellipsis,
                    textColor: Color(0xFF1E1E1E),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
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
                      const DefaultText(
                        text: 'كورنيش النيل - المعادي - القاهرة - مصر',
                        overflow: TextOverflow.ellipsis,
                        textColor: Color(0xFF1E1E1E),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
