import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/constants/cache_keys.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/enums.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router_names.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_button.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text_field.dart';

import '../../../services/cache_helper.dart';
import '../../widgets/default_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  bool _hidePassword = true;
  bool _agreed = false;

  bool _client = false;

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _bloodTypeController.dispose();
    _industryController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          final cubit = AuthCubit.get(context);
          // if (state is RegisterSuccess) {
          //   cubit.login(
          //       password: _passwordController.text.trim(),
          //       mobile: cubit.phoneNum);
          // }
          // if (state is LoginSuccess) {
          //   Navigator.pop(context);
          //   context.goTo(AppRouterNames.rLayout);
          // } else if (state is RegisterFailure || state is LoginFailure) {
          //   Navigator.pop(context);
          // }
        }, builder: (context, state) {
          final cubit = AuthCubit.get(context);
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 50.h, bottom: 20.h),
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
                DefaultTextField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  hintText: ' الاسم كامل',
                  hintTextColor: AppColors.textFieldBorder,
                  height: 50.h,
                  borderRadius: 100,
                  prefix: const Icon(
                    Icons.person,
                    color: AppColors.textFieldBorder,
                  ),
                ),
                SizedBox(height: 16.h),
                DefaultTextField(
                  controller: _genderController,
                  hintText: 'النوع',
                  hintTextColor: AppColors.textFieldBorder,
                  height: 50.h,
                  borderRadius: 100,
                  prefix: Icon(
                    Icons.male_rounded,
                    color: AppColors.textFieldBorder,
                  ),
                ),
                SizedBox(height: 16.h),
                DefaultTextField(
                  controller: _bloodTypeController,
                  hintText: 'فصيلة الدم',
                  hintTextColor: AppColors.textFieldBorder,
                  height: 50.h,
                  borderRadius: 100,
                  prefix: const Icon(
                    Icons.email_outlined,
                    color: AppColors.textFieldBorder,
                  ),
                ),
              ],
            ),
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: DefaultText(
                text:
                    'من خلال المتابعة وإنشاء الحساب، فإنك تقر بأنك قد قرأت و وافقت على سياسة الخصوصية الخاصة بنا',
                textColor: const Color(0xFF1E1E1E),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16.h),
            DefaultButton(
              margin: EdgeInsets.only(
                  top: 3.h, bottom: 30.h, left: 16.w, right: 16.w),
              text: "متابعة",
              buttonColor: AppColors.red,
              textColor: AppColors.white,
              radius: 800,
              height: 40.h,
              onTap: () {
                if (_nameController.text.isEmpty) {
                  showToast('الاسم مطلوب', ToastState.warning);
                } else if (_bloodTypeController.text.isEmpty) {
                  showToast('فصيلة الدم مطلوبة', ToastState.warning);
                } else if (_genderController.text.isEmpty) {
                  showToast('النوع مطلوب', ToastState.warning);
                } else {
                  CacheHelper.saveDataSharedPreference(
                      key: CacheKeys.ckUserName,
                      value: _nameController.text.trim());
                  Navigator.pushNamed(context, AppRouterNames.rLayout);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
