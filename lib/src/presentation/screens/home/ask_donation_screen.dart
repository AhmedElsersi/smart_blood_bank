import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text_field.dart';

import '../../../constants/const_methods.dart';
import '../../../constants/enums.dart';
import '../../router/app_router_names.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_text.dart';

class AskDonationScreen extends StatefulWidget {
  const AskDonationScreen({super.key});

  @override
  State<AskDonationScreen> createState() => _AskDonationScreenState();
}

class _AskDonationScreenState extends State<AskDonationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    _genderController.text = genders[0];
    _bloodTypeController.text = bloodTypes[0];
    governorate = governorates[0];
    city = cites[0];
    hospital = hospitals[0];
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _bloodTypeController.dispose();
    _birthController.dispose();
    _dayController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  List<String> genders = ['ذكر', 'أنثي'];
  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'C+', 'C-', 'AB+', 'AB-'];
  List<String> selectedBloodTypes = [];

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
  String hospital = '';
  List<String> hospitals = [
    'مستشفي السلام الدولي التخصصي',
    'مستشفي دارالسلام الدولي التخصصي',
    'مستشفي الجلاء الدولي التخصصي',
    'مستشفي نوح الدولي التخصصي',
  ];

  Future<void> _getDate(BuildContext context, bool isBirth) async {
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
        if (isBirth) {
          _birthController.text = cal[0];
        } else {
          _dayController.text = cal[0];
        }
      });
    }
  }

  Future<void> _getTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.now());
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.red, // Change the primary color
              onPrimary:
                  Colors.white, // Change the text color on the primary color
              surface:
                  Colors.white, // Change the background color of the calendar
              onSurface:
                  Colors.black, // Change the text color on the background color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _timeController.text = selectedTime.format(context);
      });
    }
  }

  bool _isHopital = false;

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
                left: 24.w, right: 24.w, top: 50.h, bottom: 80.h),
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
                  text: 'لطلب التبرع مطلوب معرفة البيانات الاتية',
                  textColor: Color(0xFF1E1E1E),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 20.h),
                // DefaultTextField(
                //   controller: _nameController,
                //   keyboardType: TextInputType.name,
                //   hintText: ' الاسم كامل',
                //   hintTextColor: AppColors.textFieldBorder,
                //   height: 50.h,
                //   borderRadius: 100,
                //   padding: EdgeInsets.symmetric(horizontal: 12.w),
                //
                //   // prefix: const Icon(
                //   //   Icons.person,
                //   //   color: AppColors.textFieldBorder,
                //   // ),
                //   onTap: () {},
                // ),
                // SizedBox(height: 16.h),
                // Column(
                //   children: [
                //     Container(
                //       height: 50.h,
                //       padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(150),
                //         border: Border.all(
                //           color: const Color(0xFFC8C8C8),
                //         ),
                //       ),
                //       child: DropdownButton<String>(
                //         value: _genderController.text,
                //         enableFeedback: true,
                //         autofocus: true,
                //         isExpanded: true,
                //         focusColor: Colors.transparent,
                //         dropdownColor: Colors.white,
                //         borderRadius: BorderRadius.circular(20),
                //         underline: const SizedBox(),
                //         icon: const RotatedBox(
                //           quarterTurns: 1,
                //           child: Icon(
                //             Icons.arrow_back_ios_rounded,
                //             color: Colors.black,
                //             size: 16,
                //           ),
                //         ),
                //         style:
                //             const TextStyle(fontSize: 20, color: Colors.black),
                //         onChanged: (value) {
                //           setState(() {
                //             _genderController.text = value!;
                //           });
                //         },
                //         alignment: Alignment.center,
                //         padding: EdgeInsets.symmetric(horizontal: 12.w),
                //         items: genders
                //             .map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem<String>(
                //               alignment: Alignment.centerRight,
                //               value: value,
                //               child: DefaultText(
                //                 text: value,
                //                 fontWeight: FontWeight.w500,
                //               ));
                //         }).toList(),
                //       ),
                //     ),
                //     SizedBox(height: 16.h),
                //     Container(
                //       height: 50.h,
                //       padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(150),
                //         border: Border.all(
                //           color: const Color(0xFFC8C8C8),
                //         ),
                //       ),
                //       child: DropdownButton<String>(
                //         value: _bloodTypeController.text,
                //         enableFeedback: true,
                //         autofocus: true,
                //         isExpanded: true,
                //         focusColor: Colors.transparent,
                //         dropdownColor: Colors.white,
                //         borderRadius: BorderRadius.circular(20),
                //         underline: const SizedBox(),
                //         icon: const RotatedBox(
                //           quarterTurns: 1,
                //           child: Icon(
                //             Icons.arrow_back_ios_rounded,
                //             color: Colors.black,
                //             size: 16,
                //           ),
                //         ),
                //         style:
                //             const TextStyle(fontSize: 20, color: Colors.black),
                //         onChanged: (value) {
                //           setState(() {
                //             _bloodTypeController.text = value!;
                //           });
                //         },
                //         alignment: Alignment.center,
                //         padding: EdgeInsets.symmetric(horizontal: 12.w),
                //         items: bloodTypes
                //             .map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem<String>(
                //               alignment: Alignment.centerRight,
                //               value: value,
                //               child: DefaultText(
                //                 text: value,
                //                 fontWeight: FontWeight.w500,
                //               ));
                //         }).toList(),
                //       ),
                //     ),
                //     SizedBox(height: 16.h),
                //     DefaultTextField(
                //       controller: _birthController,
                //       keyboardType: TextInputType.name,
                //       hintText: 'تاريخ الميلاد',
                //       hintTextColor: AppColors.textFieldBorder,
                //       height: 50.h,
                //       borderRadius: 100,
                //       readOnly: true,
                //       padding: EdgeInsets.symmetric(horizontal: 12.w),
                //       // prefix: const Icon(
                //       //   Icons.calendar_month_rounded,
                //       //   color: AppColors.textFieldBorder,
                //       // ),
                //       suffix: const RotatedBox(
                //         quarterTurns: 1,
                //         child: Icon(
                //           Icons.arrow_back_ios_rounded,
                //           color: Colors.black,
                //           size: 16,
                //         ),
                //       ),
                //       onTap: () => _getDate(context, true),
                //     ),
                //     SizedBox(height: 16.h),
                //   ],
                // ),
                SizedBox(height: 16.h),
                DefaultText(
                  text: 'مكان التبرع',
                  textColor: Color(0xFF1E1E1E),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                Container(
                  height: 50.h,
                  padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 0),
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
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        governorate = value!;
                      });
                    },
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    alignment: Alignment.center,
                    items: governorates
                        .map<DropdownMenuItem<String>>((String value) {
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
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        city = value!;
                      });
                    },
                    alignment: Alignment.center,
                    items: cites.map<DropdownMenuItem<String>>((String value) {
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
                    value: hospital,
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
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        hospital = value!;
                      });
                    },
                    alignment: Alignment.center,
                    items:
                        hospitals.map<DropdownMenuItem<String>>((String value) {
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
                const DefaultText(
                  text: 'ميعاد التبرع',
                  textColor: Color(0xFF1E1E1E),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                DefaultTextField(
                  controller: _dayController,
                  keyboardType: TextInputType.name,
                  hintText: 'اليوم',
                  hintTextColor: AppColors.textFieldBorder,
                  height: 50.h,
                  borderRadius: 100,
                  readOnly: true,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  // prefix: const Icon(
                  //   Icons.calendar_month_rounded,
                  //   color: AppColors.textFieldBorder,
                  // ),
                  suffix: const RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                  onTap: () => _getDate(context, false),
                ),
                SizedBox(height: 16.h),
                DefaultTextField(
                  controller: _timeController,
                  keyboardType: TextInputType.name,
                  hintText: 'الساعة',
                  hintTextColor: AppColors.textFieldBorder,
                  height: 50.h,
                  borderRadius: 100,
                  readOnly: true,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  // prefix: const Icon(
                  //   Icons.calendar_month_rounded,
                  //   color: AppColors.textFieldBorder,
                  // ),
                  suffix: const RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                  onTap: () => _getTime(context),
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
                  // CacheHelper.saveDataSharedPreference(
                  //     key: CacheKeys.ckUserName,
                  //     value: _nameController.text.trim());
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
