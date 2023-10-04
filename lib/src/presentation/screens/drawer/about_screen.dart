import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        toolbarHeight: 60.h,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const DefaultText(
          text: 'About',
          textColor: AppColors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 32.sp,
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Column(
            children: [
              SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: Image.asset(AppAssets.imgAbout)),
              const DefaultText(
                text:
                    "We Love Our Country And Want Good For It, So We Saw That We Should Present What We Can In Our Field, Which Is Industry, Aiming To Increase Egypt’s Income From Industry, Reduce Production Costs, Reduce Imported Machinery And Raw Materials, And Preserve The Environment .. As This Site Aims To Reduce Losses From Stopping Machines Due To Lack Of Work Orders As Well As Reducing The Waste Of Raw Materials Due To The Remaining Areas Of Them That Are Not Suitable For Our Products. And Just As There Is Money That May Be Wasted In Not Operating The Machines At Their Full Capacity Or In Manufacturing Raw Materials In Full Quantities, There Is Also A Waste Of Human Energies That Can Provide A Lot Of Design, Planning And Supervision Services. Industrial Integration In Egypt",
                textColor: AppColors.tColor4,
                fontSize: 15,
                maxLines: 100,
                height: 2.5,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
