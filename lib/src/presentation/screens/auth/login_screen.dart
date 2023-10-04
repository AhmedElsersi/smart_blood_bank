import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../constants/colors.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 150),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                const Align(
                    alignment: Alignment.centerRight,
                    child: DefaultText(text: 'برجاء إدخال رقم الهاتف')),
                SizedBox(
                  height: 3.h,
                ),
                const Align(
                    alignment: Alignment.centerRight,
                    child: DefaultText(
                        text:
                            'سنرسل رمزًا للتحقق من رقم الهاتف المحمول أدناه')),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      border: Border.all(color: AppColors.grey),
                    ),
                    child: InternationalPhoneNumberInput(
                      textFieldController: _controller,
                      initialValue: number,
                      maxLength: 12,
                      selectorTextStyle: const TextStyle(fontSize: 16),
                      spaceBetweenSelectorAndTextField: 0,
                      keyboardType: TextInputType.phone,
                      inputBorder: InputBorder.none,
                      selectorConfig:
                          const SelectorConfig(trailingSpace: false),
                      hintText: 'xxxxxxxxxx',
                      formatInput: true,
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 18),
                      ignoreBlank: true,
                      locale: 'SA',
                      countries: const ['SA', 'EG'],
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: DefaultButton(
        margin:
            EdgeInsets.only(top: 3.h, bottom: 20.h, left: 16.w, right: 16.w),
        text: "ارسل كود التفعيل",
        buttonColor:
            _controller.text.length > 10 ? AppColors.red : AppColors.grey,
        textColor: AppColors.white,
        radius: 100,
        height: 40.h,
        onTap: _controller.text.length > 10
            ? () {
                Navigator.pushNamed(context, AppRouterNames.rOtp);
              }
            : () {},
      ),
    );
  }
}
