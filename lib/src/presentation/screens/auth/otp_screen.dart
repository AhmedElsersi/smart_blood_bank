import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router_names.dart';

import '../../../constants/colors.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/loading_indicator.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController _controller;
  bool _error = false;
  Timer? _timer;
  int _time = 120;

  String _getTimer(int timeInSeconds) {
    final min = (timeInSeconds ~/ 60).toString().padLeft(2, '0');
    final sec = (timeInSeconds % 60).toString().padLeft(2, '0');
    final time = '$min : $sec';
    return time;
  }

  void _initializeTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          if (_time == 0) {
            _timer?.cancel();
            _time = 120;
          } else {
            _time--;
          }
        });
      },
    );
  }

  _toHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouterNames.rLayout,
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initializeTimer();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
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
                  'برجاء إدخال رمز التحقق المكون من 6 أرقام ، المرسل إلى رقم الهاتف  ${AuthCubit.get(context).phone?[0].replaceAll('+', '')}${AuthCubit.get(context).phone?[1]}',
              textColor: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  activeColor: AppColors.red,
                  fieldHeight: 64,
                  fieldWidth: 54,
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
                DefaultText(
                    text: 'لم يتم ارسال الرمز ؟',
                    textColor: AppColors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
                InkWell(
                  onTap: () {
                    if (_timer!.isActive) {
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return const LoadingIndicator();
                        },
                      );
                      AuthCubit.get(context).verifyFirebasePhone(
                        afterSuccess: () {
                          Navigator.pop(context);
                          _initializeTimer();
                        },
                        afterError: () => Navigator.pop(context),
                        phoneNumber: AuthCubit.get(context).phone!,
                      );
                    }
                  },
                  child: DefaultText(
                      text: 'إعادة الإرسال',
                      textColor: _timer?.isActive ?? true
                          ? AppColors.grey
                          : AppColors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          final cubit = AuthCubit.get(context);
          if (state is VerifyingOtpSuccessState) {
            cubit.verifyPhone();
          } else if (state is VerifyingOtpFailureState) {
            Navigator.pop(context);
            setState(() {
              _error = true;
            });
          } else if (state is VerifyPhoneSuccess) {
            Navigator.pop(context);
            _toHome();
          } else if (state is VerifyPhoneFailure) {
            Navigator.pop(context);
            context.goTo(AppRouterNames.rSignUp);
          }
        },
        child: DefaultButton(
          margin:
              EdgeInsets.only(top: 3.h, bottom: 30.h, left: 16.w, right: 16.w),
          text: "تأكيد",
          buttonColor:
              _controller.text.length < 4 ? AppColors.grey : AppColors.red,
          textColor: AppColors.white,
          radius: 800,
          height: 40.h,
          onTap: _controller.text.length > 5
              ? () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return const Center(child: LoadingIndicator());
                    },
                  );
                  AuthCubit.get(context)
                      .verifyFirebaseOTp(code: _controller.text);
                }
              : () {
                  print('kkk');
                },
        ),
      ),
    );
  }
}
