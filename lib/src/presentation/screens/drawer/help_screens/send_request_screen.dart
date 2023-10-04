import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/presentation/widgets/custom_country_picker_dialog.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_button.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text_field.dart';

import '../../../../constants/const_methods.dart';

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen({super.key});

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _adIdController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _typeController.dispose();
    _adIdController.dispose();
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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        toolbarHeight: 60.h,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const DefaultText(
          text: 'Sand A Request',
          textColor: AppColors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 32.sp,
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultText(
                text: 'Name',
                textAlign: TextAlign.center,
                fontSize: 13,
                textColor: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.h),
              DefaultTextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                hintText: '',
                hintTextColor: AppColors.textFieldBorder,
                height: 32.h,
                borderRadius: 10,
                prefix: const Icon(
                  Icons.person,
                  color: AppColors.transparent,
                ),
                onTap: () {
                  logSuccess('jjjjjjjjjjjjjjjjj');
                },
              ),
              SizedBox(height: 16.h),
              const DefaultText(
                text: 'Email',
                textAlign: TextAlign.center,
                fontSize: 13,
                textColor: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.h),
              DefaultTextField(
                controller: _emailController,
                keyboardType: TextInputType.name,
                hintText: '',
                hintTextColor: AppColors.textFieldBorder,
                height: 32.h,
                borderRadius: 10,
                prefix: const Icon(
                  Icons.email_rounded,
                  color: AppColors.textFieldBorder,
                ),
                onTap: () {
                  logSuccess('jjjjjjjjjjjjjjjjj');
                },
              ),
              SizedBox(height: 16.h),
              const DefaultText(
                text: 'Mobile',
                textAlign: TextAlign.center,
                fontSize: 13,
                textColor: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  InkWell(
                    onTap: _showCountryPicker,
                    child: Container(
                      height: 32.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      margin: EdgeInsets.only(right: 8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.textFieldBorder),
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
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      hintText: 'Mobile Number',
                      hintTextColor: AppColors.textFieldBorder,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.deny(
                          RegExp(r'^0+'),
                        ),
                      ],
                      height: 32.h,
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
              const DefaultText(
                text: 'Type',
                textAlign: TextAlign.center,
                fontSize: 13,
                textColor: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.h),
              DefaultTextField(
                controller: _typeController,
                keyboardType: TextInputType.name,
                hintText: '',
                readOnly: true,
                hintTextColor: AppColors.textFieldBorder,
                height: 32.h,
                borderRadius: 10,
                suffix: Icon(
                  Icons.arrow_drop_down_sharp,
                  size: 24.sp,
                  color: AppColors.textFieldBorder,
                ),
                onTap: () {
                  logSuccess('jjjjjjjjjjjjjjjjj');
                },
              ),
              SizedBox(height: 16.h),
              const DefaultText(
                text: 'Ad Id',
                textAlign: TextAlign.center,
                fontSize: 13,
                textColor: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.h),
              DefaultTextField(
                controller: _adIdController,
                keyboardType: TextInputType.name,
                hintText: '',
                hintTextColor: AppColors.textFieldBorder,
                height: 32.h,
                borderRadius: 10,
                onTap: () {
                  logSuccess('jjjjjjjjjjjjjjjjj');
                },
              ),
              SizedBox(height: 24.h),
              Container(
                height: 168.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.textFieldBorder),
                  color: AppColors.transparent,
                ),
              ),
              SizedBox(height: 40.h),
              DefaultButton(
                onTap: () {},
                height: 44.h,
                radius: 11,
                buttonColor: AppColors.primary,
                text: 'Submit a Request',
                textColor: AppColors.white,
                fontSize: 21,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        ),
      ),
    );
  }
}
