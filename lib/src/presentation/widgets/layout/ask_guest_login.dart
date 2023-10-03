import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masnaay/src/constants/colors.dart';
import 'package:masnaay/src/constants/navigator_extension.dart';
import 'package:masnaay/src/presentation/router/app_router_names.dart';
import 'package:masnaay/src/presentation/widgets/default_text.dart';

class AskGuestLogin extends StatelessWidget {
  const AskGuestLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultText(
            text: 'You need to Login first',
            fontSize: 16,
            textColor: AppColors.tColor1,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            width: 8.w,
          ),
          DefaultText(
            text: 'Login',
            fontSize: 18,
            textColor: AppColors.blue,
            fontWeight: FontWeight.bold,
            onTap: () {
              context.goTo(AppRouterNames.rLogin);
            },
          ),
        ],
      ),
    );
  }
}
