import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../constants/colors.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_text.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20.h, right: 4.w, left: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(2),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              DefaultText(
                text: 'رمز التحقق',
                textColor: AppColors.grey,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10.h),
              DefaultText(
                text: 'ادخل رمز التحقق المكون من 6 ارقام',
                textColor: AppColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 30.h),
              OTPTextField(
                  //controller: otpController,
                  length: 4,
                  keyboardType: TextInputType.number,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                  fieldWidth: 50,
                  fieldStyle: FieldStyle.box,
                  otpFieldStyle: OtpFieldStyle(focusBorderColor: AppColors.red),
                  outlineBorderRadius: 5,
                  style: const TextStyle(fontSize: 17),
                  onChanged: (pin) {},
                  onCompleted: (pin) {}),
              SizedBox(height: 3.h),
              Center(
                child: DefaultText(
                  text: '0:45',
                  textColor: AppColors.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: DefaultText(
                        text: 'هل حصلت علي رمز التحقق؟',
                        textColor: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {},
                    child: DefaultText(
                        text: 'إعادة الإرسال',
                        textColor: AppColors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: DefaultButton(
        margin: EdgeInsets.only(top: 3.h, bottom: 3.h, left: 16.w, right: 16.w),
        text: "تأكيد",
        buttonColor: AppColors.red,
        textColor: AppColors.white,
        radius: 800,
        height: 40.h,
        onTap: () {
          // Navigator.pushNamed(context, rCongrats);
        },
      ),
    );
  }
}
