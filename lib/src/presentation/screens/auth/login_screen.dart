import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masnaay/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:masnaay/src/constants/assets.dart';
import 'package:masnaay/src/constants/colors.dart';
import 'package:masnaay/src/constants/const_methods.dart';
import 'package:masnaay/src/constants/navigator_extension.dart';
import 'package:masnaay/src/presentation/router/app_router_names.dart';
import 'package:masnaay/src/presentation/widgets/custom_country_picker_dialog.dart';
import 'package:masnaay/src/presentation/widgets/default_button.dart';
import 'package:masnaay/src/presentation/widgets/default_text.dart';
import 'package:masnaay/src/presentation/widgets/default_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  bool _hidePassword = true;
  late Country _country;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _country = CountryPickerUtils.getCountryByPhoneCode('20');
    super.initState();
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
                      text: 'Login',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 32.h),
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
                    SizedBox(height: 16.h),
                    DefaultTextField(
                      controller: _passwordController,
                      obscureText: _hidePassword,
                      hintText: 'Password',
                      hintTextColor: AppColors.textFieldBorder,
                      height: 40.h,
                      borderRadius: 10,
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            if (_hidePassword) {
                              _hidePassword = false;
                            } else {
                              _hidePassword = true;
                            }
                          });
                        },
                        child: Icon(
                          _hidePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: _hidePassword
                              ? AppColors.textFieldBorder
                              : AppColors.primary,
                        ),
                      ),
                      prefix: const Icon(
                        Icons.phone,
                        color: AppColors.textFieldBorder,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Theme(
                                data: ThemeData(
                                    unselectedWidgetColor:
                                        AppColors.textFieldBorder),
                                child: Checkbox(
                                  value: _rememberMe,
                                  side: MaterialStateBorderSide.resolveWith(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return const BorderSide(
                                            width: 2, color: AppColors.primary);
                                      }
                                      return const BorderSide(
                                          width: 1,
                                          color: AppColors.textFieldBorder);
                                    },
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  checkColor: AppColors.white,
                                  activeColor: AppColors.primary,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            const DefaultText(
                              text: 'Remember Me',
                              fontSize: 14,
                              textColor: AppColors.tColor2,
                              fontWeight: FontWeight.normal,
                            )
                          ],
                        ),
                      ],
                    ),
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        final cubit = AuthCubit.get(context);
                        if (state is LoginSuccess) {
                          Navigator.pop(context);
                          context.goToReplace(AppRouterNames.rLayout);
                        }
                        if (state is LoginFailure) {
                          Navigator.pop(context);
                        }
                      },
                      child: DefaultButton(
                        text: 'Login',
                        fontSize: 17,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w600,
                        height: 35.h,
                        radius: 1000,
                        buttonColor: AppColors.primary,
                        margin: EdgeInsets.symmetric(vertical: 24.h),
                        onTap: () async {
                          if (_phoneController.text.trim().isEmpty) {
                            'phoneNumberRequired'.toToastWarning();
                            return;
                          } else if (_passwordController.text.trim().isEmpty) {
                            'password Required'.toToastWarning();
                            return;
                          } else if (_phoneController.text.length < 7) {
                            'phoneNumberShort'.toToastWarning();
                            return;
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            );
                            await AuthCubit.get(context).login(
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
                          text: "Don't have an account?",
                          fontSize: 14,
                          textColor: AppColors.tColor2,
                          fontWeight: FontWeight.w500,
                        ),
                        DefaultButton(
                          text: 'Sign Up',
                          fontSize: 16,
                          textColor: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          height: 35.h,
                          width: 60.w,
                          radius: 1000,
                          buttonColor: AppColors.transparent,
                          onTap: () {
                            context.goTo(AppRouterNames.rRegister);
                          },
                        ),
                      ],
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
