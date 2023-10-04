import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/models/industries_model.dart';
import 'package:smart_blood_bank/src/models/interests_model.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router_names.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_button.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  bool _hidePassword = true;
  bool _agreed = false;

  bool _client = false;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _industryController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    AuthCubit.get(context).getIndustries();
    AuthCubit.get(context).getInterests();
    super.initState();
  }

  List<IndustriesModel> selectedIndustries = [];
  List<InterestsModel> selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          final cubit = AuthCubit.get(context);
          if (state is RegisterSuccess) {
            cubit.login(
                password: _passwordController.text.trim(),
                mobile: cubit.phoneNum);
          }
          if (state is LoginSuccess) {
            Navigator.pop(context);
            context.goTo(AppRouterNames.rLayout);
          } else if (state is RegisterFailure || state is LoginFailure) {
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          final cubit = AuthCubit.get(context);
          return SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                    top: -150.h,
                    left: -22.w,
                    child: SvgPicture.asset(AppAssets.imgLoginTop)),
                Padding(
                  padding: EdgeInsets.only(
                      left: 24.w, right: 24.w, top: 130.h, bottom: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const DefaultText(
                        text: 'Create New Account',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 20.h),
                      DefaultTextField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        hintText: 'Name',
                        hintTextColor: AppColors.textFieldBorder,
                        height: 40.h,
                        borderRadius: 10,
                        prefix: const Icon(
                          Icons.person,
                          color: AppColors.textFieldBorder,
                        ),
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
                        prefix: Icon(
                          Icons.lock_open_rounded,
                          color: AppColors.textFieldBorder,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      DefaultTextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email',
                        hintTextColor: AppColors.textFieldBorder,
                        height: 40.h,
                        borderRadius: 10,
                        prefix: const Icon(
                          Icons.email_outlined,
                          color: AppColors.textFieldBorder,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      DefaultTextField(
                        controller: _industryController,
                        readOnly: true,
                        keyboardType: TextInputType.name,
                        hintText: 'Industry',
                        hintTextColor: AppColors.textFieldBorder,
                        height: 40.h,
                        borderRadius: 10,
                        prefix: const Icon(
                          Icons.email_outlined,
                          color: AppColors.transparent,
                        ),
                        suffix: Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 24.sp,
                          color: AppColors.textFieldBorder,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return MultiSelectDialog<IndustriesModel>(
                                height: 200.h,
                                items: cubit.industries
                                    .map((e) => MultiSelectItem(
                                        e, e.industryName ?? ''))
                                    .toList(),
                                initialValue: selectedIndustries,
                                onConfirm: (values) {
                                  selectedIndustries = values;
                                  logSuccess(selectedIndustries.toString());
                                },
                                searchable: true,
                                selectedColor: AppColors.primary,
                                title: const DefaultText(
                                  text: "Industries",
                                  textColor: AppColors.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      DefaultTextField(
                        controller: _interestController,
                        readOnly: true,
                        keyboardType: TextInputType.name,
                        hintText: 'Interest',
                        hintTextColor: AppColors.textFieldBorder,
                        height: 40.h,
                        borderRadius: 10,
                        prefix: const Icon(
                          Icons.email_outlined,
                          color: AppColors.transparent,
                        ),
                        suffix: Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 24.sp,
                          color: AppColors.textFieldBorder,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return MultiSelectDialog<InterestsModel>(
                                height: 200.h,
                                items: cubit.interests
                                    .map((e) => MultiSelectItem(
                                        e, e.interestName ?? ''))
                                    .toList(),
                                initialValue: selectedInterests,
                                onConfirm: (values) {
                                  selectedInterests = values;
                                  logSuccess(selectedInterests.toString());
                                },
                                searchable: true,
                                selectedColor: AppColors.primary,
                                title: const DefaultText(
                                  text: "Interests",
                                  textColor: AppColors.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: DefaultButton(
                                text: 'Client',
                                fontSize: 15,
                                textColor:
                                    _client ? AppColors.white : AppColors.blue,
                                fontWeight: FontWeight.w600,
                                height: 30.h,
                                radius: 10,
                                buttonColor: _client
                                    ? AppColors.blue
                                    : AppColors.transparent,
                                border: _client
                                    ? null
                                    : Border.all(
                                        color: AppColors.blue, width: 2),
                                margin: EdgeInsets.symmetric(
                                    vertical: 24.h, horizontal: 24.w),
                                onTap: () {
                                  setState(() {
                                    _client = true;
                                  });
                                  cubit.userTypeId = 1;
                                },
                              ),
                            ),
                            Expanded(
                              child: DefaultButton(
                                text: 'Owner',
                                fontSize: 15,
                                textColor:
                                    !_client ? AppColors.white : AppColors.blue,
                                fontWeight: FontWeight.w600,
                                height: 30.h,
                                radius: 10,
                                buttonColor: !_client
                                    ? AppColors.blue
                                    : AppColors.transparent,
                                border: !_client
                                    ? null
                                    : Border.all(
                                        color: AppColors.blue, width: 2),
                                margin: EdgeInsets.symmetric(
                                    vertical: 24.h, horizontal: 24.w),
                                onTap: () {
                                  setState(() {
                                    _client = false;
                                  });
                                  cubit.userTypeId = 0;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor:
                                      AppColors.textFieldBorder),
                              child: Checkbox(
                                value: _agreed,
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
                                    _agreed = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          const DefaultText(
                            text: "I Agree To All  ",
                            fontSize: 13,
                            textColor: AppColors.tColor2,
                            fontWeight: FontWeight.w500,
                          ),
                          DefaultText(
                            text: 'Terms And Conditions',
                            fontSize: 13,
                            textColor: AppColors.blue,
                            fontWeight: FontWeight.bold,
                            onTap: () {
                              context.goTo(AppRouterNames.rTermsAndConditions);
                            },
                          ),
                        ],
                      ),
                      DefaultButton(
                        text: 'Sign Up',
                        fontSize: 17,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w600,
                        height: 35.h,
                        radius: 1000,
                        buttonColor: AppColors.primary,
                        margin: EdgeInsets.symmetric(vertical: 24.h),
                        onTap: () {
                          if (_nameController.text.isEmpty) {
                            'name field is Required'.toToastWarning();
                            return;
                          } else if (_emailController.text.isEmpty) {
                            'email field is Required'.toToastWarning();
                            return;
                          } else if (_passwordController.text.isEmpty) {
                            'password field is Required'.toToastWarning();
                            return;
                          } else if (selectedIndustries.isEmpty) {
                            'you have to choose one industry at least'
                                .toToastWarning();
                            return;
                          } else if (selectedInterests.isEmpty) {
                            'you have to choose one interest at least'
                                .toToastWarning();
                            return;
                          } else if (!_agreed) {
                            'you need to agree our terms and Conditions first'
                                .toToastWarning();
                            return;
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            );
                            AuthCubit.get(context).register(
                              name: _nameController.text.trim(),
                              password: _passwordController.text.trim(),
                              email: _emailController.text.trim(),
                              selectedIndustries: selectedIndustries
                                  .map((e) => e.industryId ?? 0)
                                  .toList(),
                              selectedInterests: selectedInterests
                                  .map((e) => e.interestId ?? 0)
                                  .toList(),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            3,
                            (index) => Container(
                                  height: 8,
                                  width: 8,
                                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                                  decoration: BoxDecoration(
                                      color: index == 2
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
          );
        }),
      ),
    );
  }
}
