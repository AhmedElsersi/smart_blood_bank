import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:smart_blood_bank/src/business_logic/donnation_cubit/donations_cubit.dart';
import 'package:smart_blood_bank/src/business_logic/places_cubit/places_cubit.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text_field.dart';

import '../../../constants/const_methods.dart';
import '../../../constants/enums.dart';
import '../../../models/places_model.dart';
import '../../router/app_router_names.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/loading_indicator.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
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
    PlacesCubit.get(context).getBloodBanks();
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
  PlaceModel bloodBank = PlaceModel();
  List<PlaceModel> bloodBanks = [];

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
      child: BlocListener<PlacesCubit, PlacesState>(
        listener: (context, state) {
          final cubit = PlacesCubit.get(context);
          if (state is GetBloodBanksSuccess) {
            bloodBanks = cubit.places;
            bloodBank = bloodBanks.first;
            setState(() {});
          }
        },
        child: BlocConsumer<DonationsCubit, DonationsState>(
            listener: (context, state) {
          final cubit = DonationsCubit.get(context);
          if (state is DonateSuccess) {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRouterNames.rLayout);
          } else {
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          final cubit = DonationsCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
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
                      items:
                          cites.map<DropdownMenuItem<String>>((String value) {
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
                    child: DropdownButton<PlaceModel>(
                      value: bloodBank,
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
                          bloodBank = value!;
                        });
                      },
                      alignment: Alignment.center,
                      items: bloodBanks.map<DropdownMenuItem<PlaceModel>>(
                          (PlaceModel value) {
                        return DropdownMenuItem<PlaceModel>(
                            alignment: Alignment.centerRight,
                            value: value,
                            child: DefaultText(
                              text: value.name ?? '',
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
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
                    if (hospital == "") {
                      showToast('بنك الدم مطلوب', ToastState.warning);
                    } else if (_dayController.text.isEmpty) {
                      showToast('اليوم مطلوب', ToastState.warning);
                    } else if (_timeController.text.isEmpty) {
                      showToast('الوقت مطلوب', ToastState.warning);
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return const Center(child: LoadingIndicator());
                        },
                      );
                      cubit.donate(
                          donorId:
                              AuthCubit.get(context).registerModel.data?.id ??
                                  1,
                          bloodBankId: bloodBank.id ?? 1,
                          donationDay: _dayController.text,
                          donationTime: _timeController.text);
                    }
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
