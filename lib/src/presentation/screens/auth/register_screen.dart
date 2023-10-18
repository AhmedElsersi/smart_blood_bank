import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/constants/cache_keys.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/constants/const_methods.dart';
import 'package:smart_blood_bank/src/constants/enums.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
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
  final TextEditingController _birthController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _phoneController2 = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  @override
  void initState() {
    _nameController.clear();
    _genderController.text = genders[0];
    _bloodTypeController.text = bloodTypes[0].name;
    governorate = governorates[0];
    city = cites[0];
    bloodType = bloodTypes[0];
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _bloodTypeController.dispose();
    _birthController.dispose();
    _phoneController.dispose();
    _phoneController2.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  List<String> genders = ['ذكر', 'أنثي'];
  List<BloodType> bloodTypes = [
    BloodType(name: 'A+', selected: false),
    BloodType(name: 'A-', selected: false),
    BloodType(name: 'B+', selected: false),
    BloodType(name: 'B-', selected: false),
    BloodType(name: 'C+', selected: false),
    BloodType(name: 'C-', selected: false),
    BloodType(name: 'AB+', selected: false),
    BloodType(name: 'AB-', selected: false),
  ];
  List<String> selectedBloodTypes = [];

  Future<void> _getDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.red, // Change the primary color
              onPrimary:
                  Colors.white, // Change the text color on the primary color
              surface:
                  Colors.grey, // Change the background color of the calendar
              onSurface:
                  Colors.black, // Change the text color on the background color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var cal = selectedDate.toString().split(' ');
        _birthController.text = cal[0];
      });
    }
  }

  String governorate = '';
  List<String> governorates = [
    'الرياض',
    'مكة المكرمة',
    'المدينة المنورة',
    'القصيم',
    'عسير',
    'تبوك'
  ];
  String city = '';
  List<String> cites = [
    'الرياض',
    'مكة المكرمة',
    'المدينة المنورة',
    'القصيم',
    'عسير',
    'تبوك'
  ];
  BloodType bloodType = BloodType(name: 'name', selected: false);

  // Donor | Hospital | BloodBank | Recipient
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          final cubit = AuthCubit.get(context);
        }, builder: (context, state) {
          final cubit = AuthCubit.get(context);
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 50.h, bottom: 20.h),
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
                      text:
                          'لتسجيل ك${getArabicTypes(cubit.userType)} مطلوب معرفة البيانات الاتية',
                      textColor: const Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 20.h),
                    DefaultTextField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      hintText: ' الاسم كامل',
                      hintTextColor: AppColors.textFieldBorder,
                      height: 50.h,
                      borderRadius: 100,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      onTap: () {},
                    ),
                    SizedBox(height: 16.h),
                    if (cubit.userType == 'Donor' ||
                        cubit.userType == 'Recipient')
                      Column(
                        children: [
                          Container(
                            height: 50.h,
                            padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150),
                              border: Border.all(
                                color: const Color(0xFFC8C8C8),
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: _genderController.text,
                              enableFeedback: true,
                              autofocus: true,
                              isExpanded: true,
                              focusColor: Colors.transparent,
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              underline: const SizedBox(),
                              icon: const RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              onChanged: (value) {
                                setState(() {
                                  _genderController.text = value!;
                                });
                              },
                              alignment: Alignment.center,
                              items: genders.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    alignment: Alignment.centerRight,
                                    value: value,
                                    child: Row(
                                      children: [
                                        Icon(
                                          value == 'ذكر'
                                              ? Icons.male_rounded
                                              : Icons.female_rounded,
                                          color: AppColors.textFieldBorder,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        DefaultText(
                                          text: value,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ));
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            height: 50.h,
                            padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150),
                              border: Border.all(
                                color: const Color(0xFFC8C8C8),
                              ),
                            ),
                            child: DropdownButton<BloodType>(
                              value: bloodType,
                              enableFeedback: true,
                              autofocus: true,
                              isExpanded: true,
                              focusColor: Colors.transparent,
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              underline: const SizedBox(),
                              icon: const RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              onChanged: (value) {
                                setState(() {
                                  _bloodTypeController.text = value!.name!;
                                });
                              },
                              alignment: Alignment.center,
                              items: bloodTypes
                                  .map<DropdownMenuItem<BloodType>>(
                                      (BloodType value) {
                                return DropdownMenuItem<BloodType>(
                                    alignment: Alignment.centerRight,
                                    value: value,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.bloodtype_rounded,
                                          color: AppColors.textFieldBorder,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        DefaultText(
                                          text: value.name,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ));
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          DefaultTextField(
                            controller: _birthController,
                            keyboardType: TextInputType.name,
                            hintText: 'تاريخ الميلاد',
                            hintTextColor: AppColors.textFieldBorder,
                            height: 50.h,
                            borderRadius: 100,
                            readOnly: true,
                            prefix: const Icon(
                              Icons.calendar_month_rounded,
                              color: AppColors.textFieldBorder,
                            ),
                            suffix: const RotatedBox(
                              quarterTurns: 1,
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                            onTap: () => _getDate(context),
                          ),
                          SizedBox(height: 16.h),
                          DefaultTextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            hintText: 'رقم الهاتف',
                            hintTextColor: AppColors.textFieldBorder,
                            height: 50.h,
                            borderRadius: 100,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            onTap: () {},
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    if (cubit.userType == 'Hospital' ||
                        cubit.userType == 'BloodBank')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50.h,
                            padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                            margin: EdgeInsets.only(top: 10.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150),
                              border: Border.all(
                                color: const Color(0xFFC8C8C8),
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: governorate,
                              enableFeedback: true,
                              autofocus: true,
                              isExpanded: true,
                              focusColor: Colors.transparent,
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              underline: const SizedBox(),
                              icon: const RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              onChanged: (value) {
                                setState(() {
                                  governorate = value!;
                                });
                              },
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              alignment: Alignment.center,
                              items: governorates.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    alignment: Alignment.centerRight,
                                    value: value,
                                    child: DefaultText(
                                      text: value,
                                      fontWeight: FontWeight.w500,
                                    ));
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            height: 50.h,
                            padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150),
                              border: Border.all(
                                color: const Color(0xFFC8C8C8),
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: city,
                              enableFeedback: true,
                              autofocus: true,
                              isExpanded: true,
                              focusColor: Colors.transparent,
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              underline: const SizedBox(),
                              icon: const RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              onChanged: (value) {
                                setState(() {
                                  city = value!;
                                });
                              },
                              alignment: Alignment.center,
                              items: cites.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    alignment: Alignment.centerRight,
                                    value: value,
                                    child: DefaultText(
                                      text: value,
                                      fontWeight: FontWeight.w500,
                                    ));
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          DefaultTextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            hintText: 'رقم الهاتف',
                            hintTextColor: AppColors.textFieldBorder,
                            height: 50.h,
                            borderRadius: 100,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            onTap: () {},
                          ),
                          SizedBox(height: 16.h),
                          // DefaultTextField(
                          //   controller: _phoneController2,
                          //   keyboardType: TextInputType.name,
                          //   hintText: 'رقم الهاتف اخر ( اختياري )',
                          //   hintTextColor: AppColors.textFieldBorder,
                          //   height: 50.h,
                          //   borderRadius: 100,
                          //   padding: EdgeInsets.symmetric(horizontal: 12.w),
                          //   onTap: () {},
                          // ),
                          // SizedBox(height: 16.h),
                          DefaultTextField(
                            controller: _aboutController,
                            keyboardType: TextInputType.name,
                            hintText: 'وصف مختصر',
                            hintTextColor: AppColors.textFieldBorder,
                            height: 100.h,
                            borderRadius: 20,
                            maxLines: 5,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            onTap: () {},
                          ),
                          SizedBox(height: 30.h),
                          const DefaultText(
                            text: 'فصائل الدم المتاحة',
                            textColor: Color(0xFF1E1E1E),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 0.05,
                          ),
                          SizedBox(height: 15.h),
                          const DefaultText(
                            text: ' ( يمكنك الاختيار اكثر من اختيار )',
                            textColor: Color(0xFFC8C8C8),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            height: 0.07,
                          ),
                          SizedBox(height: 20.h),
                          SizedBox(
                            height: 100.h,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.5,
                                crossAxisSpacing: 10.h,
                                mainAxisSpacing: 10.h,
                              ),
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: bloodTypes.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  InkWell(
                                onTap: () {
                                  setState(() {
                                    bloodTypes[index].selected =
                                        !bloodTypes[index].selected;
                                  });
                                  if (bloodTypes[index].selected) {
                                    selectedBloodTypes
                                        .add(bloodTypes[index].name);
                                  } else {
                                    selectedBloodTypes.removeWhere(
                                        (e) => e == bloodTypes[index].name);
                                  }
                                },
                                child: Container(
                                  // padding:
                                  //     EdgeInsets.fromLTRB(0.w, 1.h, 0.w, 1.h),
                                  decoration: BoxDecoration(
                                    color: bloodTypes[index].selected
                                        ? AppColors.red
                                        : null,
                                    border: bloodTypes[index].selected
                                        ? null
                                        : Border.all(
                                            color: const Color(0xFFC8C8C8)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: DefaultText(
                                    text: bloodTypes[index].name,
                                    textColor: bloodTypes[index].selected
                                        ? AppColors.white
                                        : const Color(0xFF1E1E1E),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: const DefaultText(
                        text:
                            'من خلال المتابعة وإنشاء الحساب، فإنك تقر بأنك قد قرأت و وافقت على سياسة الخصوصية الخاصة بنا',
                        textColor: Color(0xFF1E1E1E),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) async {
                        if (state is RegisterSuccess) {
                          // Navigator.pop(context);
                          context.goTo(AppRouterNames.rLayout);
                        } else if (state is RegisterSuccess) {
                          // Navigator.pop(context);
                          context.goTo(AppRouterNames.rLayout);
                        }
                      },
                      child: DefaultButton(
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
                          } else if (_phoneController.text.isEmpty) {
                            showToast('الهاتف مطلوب', ToastState.warning);
                          } else if (AuthCubit.get(context).userType !=
                                  'Donor' &&
                              AuthCubit.get(context).userType != 'Recipient' &&
                              selectedBloodTypes.isEmpty) {
                            showToast('فصائل الدم مطلوبة', ToastState.warning);
                          } else {
                            CacheHelper.saveDataSharedPreference(
                                key: CacheKeys.ckUserName,
                                value: _nameController.text.trim());
                            context.goTo(AppRouterNames.rLayout);

                            // showDialog(
                            //   context: context,
                            //   builder: (_) {
                            //     return const Center(child: LoadingIndicator());
                            //   },
                            // );
                            // AuthCubit.get(context).register(
                            //   name: _nameController.text.trim(),
                            //   phone: _phoneController.text.trim(),
                            //   userType: AuthCubit.get(context).userType,
                            //   type:
                            //       AuthCubit.get(context).userType == 'Donor' ||
                            //               AuthCubit.get(context).userType ==
                            //                   'Recipient'
                            //           ? _genderController.text.trim()
                            //           : null,
                            //   bloodType:
                            //       AuthCubit.get(context).userType == 'Donor' ||
                            //               AuthCubit.get(context).userType ==
                            //                   'Recipient'
                            //           ? _bloodTypeController.text.trim()
                            //           : null,
                            //   birthDate:
                            //       AuthCubit.get(context).userType == 'Donor' ||
                            //               AuthCubit.get(context).userType ==
                            //                   'Recipient'
                            //           ? _birthController.text.trim()
                            //           : null,
                            //   bloodTypes: AuthCubit.get(context).userType ==
                            //               'Hospital' ||
                            //           AuthCubit.get(context).userType ==
                            //               'BloodBank'
                            //       ? selectedBloodTypes
                            //       : null,
                            //   about: AuthCubit.get(context).userType ==
                            //               'Hospital' ||
                            //           AuthCubit.get(context).userType ==
                            //               'BloodBank'
                            //       ? _aboutController.text.trim()
                            //       : null,
                            //   location: AuthCubit.get(context).userType ==
                            //               'Hospital' ||
                            //           AuthCubit.get(context).userType ==
                            //               'BloodBank'
                            //       ? "$governorate , $city"
                            //       : null,
                            //   image: AuthCubit.get(context).userType ==
                            //               'Hospital' ||
                            //           AuthCubit.get(context).userType ==
                            //               'BloodBank'
                            //       ? 'path'
                            //       : null,
                            // );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.all(16.w),
        //       child: DefaultText(
        //         text:
        //             'من خلال المتابعة وإنشاء الحساب، فإنك تقر بأنك قد قرأت و وافقت على سياسة الخصوصية الخاصة بنا',
        //         textColor: const Color(0xFF1E1E1E),
        //         fontSize: 16,
        //         fontWeight: FontWeight.w400,
        //       ),
        //     ),
        //     SizedBox(height: 16.h),
        //     DefaultButton(
        //       margin: EdgeInsets.only(
        //           top: 3.h, bottom: 30.h, left: 16.w, right: 16.w),
        //       text: "متابعة",
        //       buttonColor: AppColors.red,
        //       textColor: AppColors.white,
        //       radius: 800,
        //       height: 40.h,
        //       onTap: () {
        //         if (_nameController.text.isEmpty) {
        //           showToast('الاسم مطلوب', ToastState.warning);
        //         } else if (_bloodTypeController.text.isEmpty) {
        //           showToast('فصيلة الدم مطلوبة', ToastState.warning);
        //         } else if (_genderController.text.isEmpty) {
        //           showToast('النوع مطلوب', ToastState.warning);
        //         } else {
        //           CacheHelper.saveDataSharedPreference(
        //               key: CacheKeys.ckUserName,
        //               value: _nameController.text.trim());
        //           Navigator.pushNamed(context, AppRouterNames.rLayout);
        //         }
        //       },
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class BloodType {
  int? id;
  String name;
  bool selected;

  BloodType({this.id, required this.name, required this.selected});
}
