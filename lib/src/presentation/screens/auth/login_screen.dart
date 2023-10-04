import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smart_blood_bank/src/business_logic/auth_cubit/auth_cubit.dart';

import '../../../constants/colors.dart';
import '../../../services/notification_service.dart';
import '../../router/app_router_names.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> _formKey;

  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _formKey.currentState!.dispose();
    super.dispose();
  }

  PhoneNumber number = PhoneNumber(isoCode: 'SA');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 60.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                  alignment: Alignment.centerRight,
                  child: DefaultText(
                    text: 'برجاء إدخال رقم الهاتف',
                    textColor: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  )),
              SizedBox(
                height: 12.h,
              ),
              const Align(
                  alignment: Alignment.centerRight,
                  child: DefaultText(
                    text: 'سنرسل رمزًا للتحقق من رقم الهاتف المحمول أدناه',
                    textColor: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  )),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 13,
                ),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    border: Border.all(color: AppColors.grey),
                  ),
                  child: InternationalPhoneNumberInput(
                    textFieldController: _controller,
                    initialValue: number,
                    maxLength: 12,
                    textAlign: TextAlign.right,
                    selectorTextStyle: const TextStyle(fontSize: 16),
                    spaceBetweenSelectorAndTextField: 10,
                    keyboardType: TextInputType.phone,
                    inputBorder: InputBorder.none,
                    selectorConfig: const SelectorConfig(trailingSpace: false),
                    hintText: 'xxxxxxxxxx',
                    formatInput: true,
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 18),
                    ignoreBlank: true,
                    locale: 'SA',
                    countries: const ['SA'],
                    onInputChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: DefaultButton(
        margin:
            EdgeInsets.only(top: 3.h, bottom: 20.h, left: 16.w, right: 16.w),
        text: "ارسل كود التفعيل",
        buttonColor:
            _controller.text.length > 11 ? AppColors.red : AppColors.grey,
        textColor: AppColors.white,
        radius: 100,
        height: 40.h,
        onTap: _controller.text.length > 10
            ? () async {
                await NotificationService.showNotification(
                  id: 0,
                  title: 'Your OTP is ',
                  body: '1234',
                );
                AuthCubit.get(context).phoneNum =
                    '+966' + '${_controller.text.replaceAll(' ', '')} ';
                // logSuccess('${AuthCubit.get(context).phoneNum}');
                Navigator.pushNamed(context, AppRouterNames.rOtp);
              }
            : () {},
      ),
    );
  }
}
