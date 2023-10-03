import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masnaay/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:masnaay/src/constants/assets.dart';
import 'package:masnaay/src/constants/colors.dart';
import 'package:masnaay/src/constants/const_methods.dart';
import 'package:masnaay/src/constants/navigator_extension.dart';
import 'package:masnaay/src/presentation/router/app_router_names.dart';
import 'package:masnaay/src/presentation/widgets/default_button.dart';
import 'package:masnaay/src/presentation/widgets/default_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? _otp;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                  top: -33.h,
                  left: -22.w,
                  child: SvgPicture.asset(AppAssets.imgLoginTop)),
              Padding(
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, top: 230.h, bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const DefaultText(
                      text: 'Verification Code',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 20.h),
                    const DefaultText(
                      text: 'We Sent You The OTP Code On Your\nMobile Number',
                      fontSize: 16,
                      maxLines: 2,
                      textColor: AppColors.tColor2,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        onChanged: (val) {
                          setState(() {
                            _otp = val;
                          });
                        },
                        onCompleted: (val) {},
                        showCursor: true,
                        cursorColor: AppColors.otpFieldBorder,
                        pinTheme: PinTheme(
                          activeColor: AppColors.primary,
                          disabledColor: AppColors.lightGrey,
                          errorBorderColor: AppColors.red,
                          selectedColor: AppColors.primary,
                          inactiveColor: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                          shape: PinCodeFieldShape.box,
                          fieldWidth: 36.h,
                          fieldHeight: 43.h,
                        ),
                        textStyle: TextStyle(
                          fontSize: 14.sp,
                        ),
                        blinkWhenObscuring: true,
                        obscureText: true,
                        autoFocus: true,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is VerifyOTPSuccess) {
                          Navigator.pop(context);
                          context.goTo(AppRouterNames.rRegister);
                        } else if (state is VerifyOTPFail) {
                          Navigator.pop(context);
                        }
                      },
                      child: DefaultButton(
                        text: 'Continue',
                        fontSize: 17,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w600,
                        height: 35.h,
                        radius: 1000,
                        buttonColor: AppColors.primary,
                        margin: EdgeInsets.symmetric(vertical: 24.h),
                        onTap: () {
                          if (_otp?.length != 4) {
                            'context.verificationCodeRequired'.toToastWarning();
                            return;
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            );
                            AuthCubit.get(context).verifyOTP(otp: _otp!);
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const DefaultText(
                          text: "Didn't Receive The Code ? ",
                          fontSize: 14,
                          textColor: AppColors.tColor2,
                          fontWeight: FontWeight.w500,
                        ),
                        DefaultButton(
                          text: 'Resend',
                          fontSize: 16,
                          textColor: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          height: 35.h,
                          width: 50.w,
                          radius: 1000,
                          buttonColor: AppColors.transparent,
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Container(
                                height: 8,
                                width: 8,
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                decoration: BoxDecoration(
                                    color: index == 1
                                        ? AppColors.primary
                                        : AppColors.lightGrey,
                                    shape: BoxShape.circle),
                              )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
