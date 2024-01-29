import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smart_blood_bank/src/constants/navigator_extension.dart';
import 'package:smart_blood_bank/src/presentation/router/app_router_names.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../constants/colors.dart';
import '../../../constants/const_methods.dart';
import '../../../constants/enums.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/default_text_field.dart';
import '../../widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _passwordController2.dispose();
    super.dispose();
  }

  PhoneNumber number = PhoneNumber(isoCode: 'SA');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 60.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: DefaultText(
                  text: 'برجاء إدخال رقم الهاتف و كلمة السر',
                  textColor: Color(0xFF1E1E1E),
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                )),
            SizedBox(
              height: 12.h,
            ),
            const DefaultText(
              text: "أدخل بيانات تسجيل الدخول",
              textColor: Color(0xFF1E1E1E),
              fontSize: 16,
              fontWeight: FontWeight.w400,
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
                  maxLength: 11,
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
            DefaultTextField(
              controller: _passwordController2,
              keyboardType: TextInputType.name,
              hintText: 'كلمة السر',
              hintTextColor: AppColors.textFieldBorder,
              height: 40.h,
              borderRadius: 100,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              onTap: () {},
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.goTo(AppRouterNames.rLayout);
          }
        },
        child: DefaultButton(
          margin:
              EdgeInsets.only(top: 3.h, bottom: 20.h, left: 16.w, right: 16.w),
          text: "تسجيل الدخول",
          buttonColor:
              _controller.text.length < 12 ? AppColors.red : AppColors.grey,
          textColor: AppColors.white,
          radius: 100,
          height: 40.h,
          onTap: _controller.text.length < 12
              ? () async {
                  if (_controller.text.trim().isEmpty ||
                      _controller.text.length < 11) {
                    showToast("أدخل رقم هاتف صحيح", ToastState.warning);
                  } else if (_passwordController2.text.trim().isEmpty) {
                    showToast("أدخل كلمة السر", ToastState.warning);
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return const Center(child: LoadingIndicator());
                      },
                    );
                    AuthCubit.get(context).login(
                      phone: _controller.text,
                      pass: _passwordController2.text,
                    );
                  }
                }
              : () {},
        ),
      ),
    );
  }
}
