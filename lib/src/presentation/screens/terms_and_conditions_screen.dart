import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masnaay/src/presentation/widgets/default_text.dart';

import '../../constants/colors.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        toolbarHeight: 60.h,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const DefaultText(
          text: 'Terms and Conditions',
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
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: const DefaultText(
            text:
                'A Terms And Conditions Agreement Is Where You Let The Public Know The Terms, Rules And Guidelines For Using Your Website Or Mobile App. They Include Topics Such As Acceptable Use, Restricted Behavior And Limitations Of Liability.A Terms And Conditions Agreement Is Where You Let The Public Know The Terms, Rules And Guidelines For Using Your Website Or Mobile App. They Include Topics Such As Acceptable Use, Restricted Behavior And Limitations Of Liability.A Terms And Conditions Agreement Is Where You Let The Public Know The Terms, Rules And Guidelines For Using Your Website Or Mobile App. They Include Topics Such As Acceptable Use, Restricted Behavior And Limitations Of Liability.A Terms And Conditions Agreement Is Where You Let The Public Know The Terms, Rules And Guidelines For Using Your Website Or Mobile App. They Include Topics Such As Acceptable Use, Restricted Behavior And Limitations Of Liability.',
            textColor: AppColors.tColor4,
            fontSize: 15,
            maxLines: 100,
            height: 2.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
