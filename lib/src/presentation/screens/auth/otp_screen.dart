import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';

import '../../../constants/colors.dart';
import '../../../constants/const_methods.dart';
import '../../../constants/enums.dart';
import '../../../services/notification_service.dart';
import '../../router/app_router_names.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_text.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController _controller;
  late Timer? timer;
  ValueNotifier<int> secondsToResend = ValueNotifier<int>(45);
  bool resend = false;

  void setCountDown() {
    resend = false;
    secondsToResend.value -= 1;
    if (secondsToResend.value < 1) {
      resend = true;
      setState(() {
        timer?.cancel();
      });
    }
  }

  @override
  void initState() {
    _controller = TextEditingController();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setCountDown();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 50.h, right: 16.w, left: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
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
            SizedBox(height: 20.h),
            DefaultText(
              text:
                  'برجاء إدخال رمز التحقق المكون من 4 أرقام ، المرسل إلى رقم الهاتف  ${AuthCubit.get(context).phoneNum}',
              textColor: const Color(0xFF1E1E1E),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: PinCodeTextField(
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  activeColor: AppColors.red,
                  fieldHeight: 64,
                  fieldWidth: 64,
                  activeFillColor: AppColors.white,
                  selectedFillColor: Colors.white,
                  selectedColor: AppColors.red,
                  borderWidth: 1,
                  inactiveFillColor: Colors.white,
                  inactiveColor: AppColors.grey,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                keyboardType: TextInputType.number,
                controller: _controller,
                onCompleted: (v) {},
                onChanged: (value) {
                  // BlocProvider.of<AuthCubit>(context)
                  //     .toggleAuthEnable(value.length);
                  setState(() {});
                },
                beforeTextPaste: (text) {
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
                appContext: context,
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const DefaultText(
                    text: 'لم يتم ارسال الرمز ؟',
                    textColor: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                InkWell(
                  onTap: () async {
                    await NotificationService.showNotification(
                      id: 0,
                      title: 'Your OTP is ',
                      body: '1234',
                    );
                  },
                  child: const DefaultText(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: DefaultButton(
        margin:
            EdgeInsets.only(top: 3.h, bottom: 30.h, left: 16.w, right: 16.w),
        text: "تأكيد",
        buttonColor:
            _controller.text.length < 4 ? AppColors.grey : AppColors.red,
        textColor: AppColors.white,
        radius: 800,
        height: 40.h,
        onTap: _controller.text.length > 3
            ? () {
                logSuccess('${_controller.text}');
                if (_controller.text == "1234") {
                  Navigator.pushNamed(context, AppRouterNames.rSignUp);
                } else {
                  showToast('أدخل الكود الصحيح', ToastState.warning);
                }
              }
            : () {
                print('kkk');
              },
      ),
    );
  }
}
