import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/constants/assets.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/const_variables.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text_field.dart';
import 'package:smart_blood_bank/src/presentation/widgets/layout/ask_guest_login.dart';
import 'package:smart_blood_bank/src/presentation/widgets/loading_indicator.dart';

import '../../../models/industries_model.dart';
import '../../../models/interests_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool editing = false;
  @override
  void initState() {
    AuthCubit.get(context).getProfile();
    super.initState();
  }

  List<IndustriesModel> selectedIndustries = [];
  List<InterestsModel> selectedInterests = [];
  bool showIndustries = false;
  bool showInterests = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      final cubit = AuthCubit.get(context);
      if (state is GetProfileSuccess) {
        _nameController.text = cubit.user.uName ?? '';
        _emailController.text = cubit.user.uEmail ?? '';
        _phoneController.text = cubit.user.uMobile ?? '';
        for (int id in cubit.user.industryIds!) {
          selectedIndustries
              .addAll(cubit.industries.where((e) => e.industryId == id));
        }
        for (int id in cubit.user.interestIds!) {
          selectedInterests
              .addAll(cubit.interests.where((e) => e.interestId == id));
        }
      } else if (state is GetProfileFailure) {
        cubit.refreshesToken();
      }
      if (state is RefreshTokenSuccess) {
        cubit.getProfile();
      }
    }, builder: (context, state) {
      final cubit = AuthCubit.get(context);
      return Scaffold(
        backgroundColor: AppColors.white,
        body: isGuest
            ? const AskGuestLogin()
            : state is GetProfileFailure
                ? const Center(child: DefaultText(text: 'error...'))
                : state is GetProfileLoading || state is RefreshTokenLoading
                    ? const Center(child: LoadingIndicator())
                    : SingleChildScrollView(
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Column(children: [
                              Container(
                                height: 180.h,
                                color: AppColors.primary,
                                padding: EdgeInsets.only(
                                    left: 12.w, right: 12.w, top: 40.h),
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.arrow_back_rounded,
                                        size: 26.sp,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    DefaultText(
                                      text:
                                          editing ? 'Edit Profile' : 'Profile',
                                      textColor: AppColors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    DefaultText(
                                      text: editing ? 'Save' : 'Edit',
                                      textColor: AppColors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      onTap: () {
                                        setState(() {
                                          editing = !editing;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.w, right: 8.w, top: 45.h),
                                child: Column(
                                  children: [
                                    ProfileComponent(
                                      editText: true,
                                      nameController: _nameController,
                                      title: 'UserName',
                                      hintText: 'name',
                                      readOnly: !editing,
                                    ),
                                    ProfileComponent(
                                      editText: true,
                                      nameController: _emailController,
                                      title: 'Email',
                                      hintText: 'email',
                                      readOnly: !editing,
                                    ),
                                    ProfileComponent(
                                      editText: true,
                                      nameController: _phoneController,
                                      title: 'Mobile',
                                      hintText: 'mobile',
                                      readOnly: !editing,
                                    ),
                                    ProfileComponent(
                                      editText: false,
                                      nameController: TextEditingController(),
                                      title: 'Industry',
                                      hintText: 'Industry',
                                      readOnly: false,
                                      onTap: editing
                                          ? () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return MultiSelectDialog<
                                                      IndustriesModel>(
                                                    height: 200.h,
                                                    items: cubit.industries
                                                        .map((e) =>
                                                            MultiSelectItem(
                                                                e,
                                                                e.industryName ??
                                                                    ''))
                                                        .toList(),
                                                    initialValue:
                                                        selectedIndustries,
                                                    onConfirm: (values) {
                                                      selectedIndustries =
                                                          values;
                                                      logSuccess(
                                                          selectedIndustries
                                                              .toString());
                                                    },
                                                    searchable: true,
                                                    selectedColor:
                                                        AppColors.primary,
                                                    title: const DefaultText(
                                                      text: "Industries",
                                                      textColor:
                                                          AppColors.primary,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          : () {
                                              setState(() {
                                                showIndustries =
                                                    !showIndustries;
                                              });
                                            },
                                    ),
                                    if (showIndustries)
                                      Column(
                                        children: List.generate(
                                            selectedIndustries.length,
                                            (index) => Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      DefaultText(
                                                        text: selectedIndustries[
                                                                    index]
                                                                .industryName ??
                                                            "",
                                                        textColor:
                                                            AppColors.tColor5,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Divider(
                                                        height: 10.h,
                                                      )
                                                    ],
                                                  ),
                                                )),
                                      ),
                                    ProfileComponent(
                                      editText: false,
                                      nameController: TextEditingController(),
                                      title: 'Interest',
                                      hintText: 'Interest',
                                      readOnly: false,
                                      rotates: showInterests ? 2 : 0,
                                      onTap: editing
                                          ? () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return MultiSelectDialog<
                                                      InterestsModel>(
                                                    height: 200.h,
                                                    items: cubit.interests
                                                        .map((e) =>
                                                            MultiSelectItem(
                                                                e,
                                                                e.interestName ??
                                                                    ''))
                                                        .toList(),
                                                    initialValue:
                                                        selectedInterests,
                                                    onConfirm: (values) {
                                                      selectedInterests =
                                                          values;
                                                    },
                                                    searchable: true,
                                                    selectedColor:
                                                        AppColors.primary,
                                                    title: const DefaultText(
                                                      text: "Interests",
                                                      textColor:
                                                          AppColors.primary,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          : () {
                                              setState(() {
                                                showInterests = !showInterests;
                                              });
                                            },
                                    ),
                                    if (showInterests)
                                      Column(
                                        children: List.generate(
                                            selectedInterests.length,
                                            (index) => Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      DefaultText(
                                                        text: selectedInterests[
                                                                    index]
                                                                .interestName ??
                                                            "",
                                                        textColor:
                                                            AppColors.tColor5,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Divider(
                                                        height: 10.h,
                                                      )
                                                    ],
                                                  ),
                                                )),
                                      )
                                  ],
                                ),
                              )
                            ]),
                            Positioned(
                              top: 100.h,
                              child: CircleAvatar(
                                radius: 75,
                                child: Image.asset(AppAssets.icDonner),
                              ),
                            ),
                            Positioned(
                              top: -103.h,
                              left: -323.w,
                              child: SvgPicture.asset(
                                AppAssets.icDonner,
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ),
                      ),
      );
    });
  }
}

class ProfileComponent extends StatelessWidget {
  const ProfileComponent({
    super.key,
    required TextEditingController nameController,
    required this.title,
    required this.hintText,
    required this.readOnly,
    this.suffix,
    required this.editText,
    this.onTap,
    this.rotates,
  }) : _nameController = nameController;

  final bool editText;
  final TextEditingController? _nameController;
  final String title;
  final String hintText;

  final bool readOnly;
  final Widget? suffix;
  final int? rotates;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            text: title,
            textColor: AppColors.tColor5,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          editText
              ? DefaultTextField(
                  controller: _nameController!,
                  hintText: hintText,
                  readOnly: readOnly,
                  height: 40.h,
                  bottomBorder: true,
                  suffix: suffix,
                  border: const Border(
                    bottom: BorderSide(color: AppColors.tColor5),
                  ),
                )
              : InkWell(
                  onTap: onTap,
                  child: Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.tColor5),
                      ),
                    ),
                    padding: EdgeInsets.only(right: 8.w),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultText(
                          text: title,
                          textColor: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        RotatedBox(
                          quarterTurns: rotates ?? 0,
                          child: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
