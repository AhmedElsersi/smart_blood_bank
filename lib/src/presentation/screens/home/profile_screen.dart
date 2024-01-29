import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/presentation/widgets/loading_indicator.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../constants/cache_keys.dart';
import '../../../constants/colors.dart';
import '../../../constants/const_variables.dart';
import '../../../services/cache_helper.dart';
import '../../widgets/default_text.dart';
import '../../widgets/default_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _userTypeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  @override
  void initState() {
    logSuccess(AuthCubit.get(context).registerModel.userType.toString());

    _userTypeController.text =
        "${AuthCubit.get(context).registerModel.userType ?? CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserType) ?? ''}";
    _nameController.text =
        "${AuthCubit.get(context).registerModel.data?.name ?? CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserName) ?? ''}";
    _bloodTypeController.text =
        "${AuthCubit.get(context).registerModel.data?.bloodTypes ?? CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserBloodType) ?? ''}";
    _phoneController.text =
        "${AuthCubit.get(context).registerModel.data?.contactDetails ?? CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserPhone) ?? ''}";
    _aboutController.text =
        "${AuthCubit.get(context).registerModel.data?.about ?? CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserAbout) ?? ''}";
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _bloodTypeController.dispose();
    _birthController.dispose();
    _phoneController.dispose();
    _userTypeController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is GetProfileSuccess) {
          _userTypeController.text =
              "${AuthCubit.get(context).registerModel.userType ?? CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserType) ?? ''}";
          _nameController.text =
              "${AuthCubit.get(context).registerModel.data?.name ?? CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserName) ?? ''}";
          _bloodTypeController.text =
              "${AuthCubit.get(context).registerModel.data?.bloodTypes ?? CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserBloodType) ?? ''}";
          _phoneController.text =
              "${AuthCubit.get(context).registerModel.data?.contactDetails ?? CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserPhone) ?? ''}";
          _aboutController.text =
              "${AuthCubit.get(context).registerModel.data?.about ?? CacheHelper.getDataFromSharedPreference(key: CacheKeys.ckUserAbout) ?? ''}";
        }
        final cubit = AuthCubit.get(context);
      }, builder: (context, state) {
        final cubit = AuthCubit.get(context);
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(left: 24.w, right: 24.w, top: 50.h, bottom: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                    text: 'الصفحة الشخصية',
                    textColor: Color(0xFF1E1E1E),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 20.h),
                  state is GetProfileLoading
                      ? SizedBox(
                          height: 500.h,
                          child: Center(child: LoadingIndicator()),
                        )
                      : Column(
                          children: [
                            DefaultTextField(
                              controller: _userTypeController,
                              keyboardType: TextInputType.name,
                              hintText: '',
                              enabled: false,
                              hintTextColor: AppColors.textFieldBorder,
                              height: 40.h,
                              borderRadius: 100,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              onTap: () {},
                            ),
                            SizedBox(height: 16.h),
                            DefaultTextField(
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              hintText: '',
                              enabled: false,
                              hintTextColor: AppColors.textFieldBorder,
                              height: 40.h,
                              borderRadius: 100,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              onTap: () {},
                            ),
                            SizedBox(height: 16.h),
                            DefaultTextField(
                              controller: _bloodTypeController,
                              keyboardType: TextInputType.name,
                              hintText: '',
                              enabled: false,
                              hintTextColor: AppColors.textFieldBorder,
                              height: 40.h,
                              borderRadius: 100,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              onTap: () {},
                            ),
                            SizedBox(height: 16.h),
                            DefaultTextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.name,
                              hintText: '',
                              enabled: false,
                              hintTextColor: AppColors.textFieldBorder,
                              height: 40.h,
                              borderRadius: 100,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              onTap: () {},
                            ),
                            SizedBox(height: 16.h),
                            if (userType == 'Hospital' ||
                                userType == 'BloodBank')
                              DefaultTextField(
                                controller: _aboutController,
                                keyboardType: TextInputType.name,
                                hintText: '',
                                enabled: false,
                                hintTextColor: AppColors.textFieldBorder,
                                height: 40.h,
                                borderRadius: 100,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                onTap: () {},
                              ),
                            SizedBox(height: 16.h),
                          ],
                        )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
