import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router_names.dart';
import 'package:smart_blood_bank/src/presentation/widgets/custom_country_picker_dialog.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_button.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  late Country _country;

  @override
  void initState() {
    super.initState();
    _country = CountryPickerUtils.getCountryByPhoneCode('20');
  }

  void _showCountryPicker() => showDialog(
        context: context,
        builder: (context) => CustomCountryPickerDialog(
          onCountryPicked: (Country country) =>
              setState(() => _country = country),
        ),
      );

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
                      text: 'Sign Up',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 20.h),
                    const DefaultText(
                      text:
                          'Enter Your Mobile Number To Send\nYou The OTP Code',
                      fontSize: 16,
                      maxLines: 2,
                      textColor: AppColors.tColor2,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        InkWell(
                          onTap: _showCountryPicker,
                          child: Container(
                            height: 40.h,
                            padding: const EdgeInsets.all(4),
                            margin: EdgeInsets.only(right: 8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.primary),
                              color: AppColors.transparent,
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DefaultText(
                                  text: "+${_country.phoneCode}",
                                  fontSize: 14,
                                  textColor: AppColors.tColor2,
                                  fontWeight: FontWeight.w500,
                                ),
                                Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 14.sp,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: DefaultTextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            hintText: 'Mobile Number',
                            hintTextColor: AppColors.textFieldBorder,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.deny(
                                RegExp(r'^0+'),
                              ),
                            ],
                            height: 40.h,
                            borderRadius: 10,
                            prefix: const Icon(
                              Icons.phone,
                              color: AppColors.textFieldBorder,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is VerifyPhoneSuccess) {
                          AuthCubit.get(context).sendOtp();
                        } else if (state is VerifyPhoneFail ||
                            state is SendOtpFail) {
                          Navigator.pop(context);
                        } else if (state is SendOtpSuccess) {
                          Navigator.pop(context);
                          context.goTo(AppRouterNames.rOtp);
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
                        onTap: () async {
                          if (_phoneController.text.trim().isEmpty) {
                            'context.phoneNumberRequired'.toToastWarning();
                            return;
                          } else if (_phoneController.text.length < 7) {
                            'context.phoneNumberShort'.toToastWarning();
                            return;
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            );
                            await AuthCubit.get(context).verifyPhone(
                              phone: [
                                "+${_country.phoneCode}",
                                _phoneController.text.trim(),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const DefaultText(
                          text: "Already Have An Account?",
                          fontSize: 14,
                          textColor: AppColors.tColor2,
                          fontWeight: FontWeight.w500,
                        ),
                        DefaultButton(
                          text: 'Login',
                          fontSize: 16,
                          textColor: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          height: 35.h,
                          width: 50.w,
                          radius: 1000,
                          buttonColor: AppColors.transparent,
                          onTap: () {
                            context.goTo(AppRouterNames.rLogin);
                          },
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
                              color: index == 0
                                  ? AppColors.primary
                                  : AppColors.lightGrey,
                              shape: BoxShape.circle),
                        ),
                      ),
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
